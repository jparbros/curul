# encoding: utf-8

namespace :migrate do

  desc "Migrate Commisions"
  task :comisiones => [:environment] do
    DB = Sequel.postgres('curul505', :user => 'jparbros', :host => 'localhost')
    members = DB[:members]
    members.each do |member|
      if member[:commission]
        member[:commission].split(/,/).each do |commision|
          unless commision.blank?
            commission = Commission.find_or_create_by_name commision.lstrip
            puts "CREANDO COMISION => #{commission.name}\n"
          end
        end
      end
    end
  end

  desc "Migrate Topics"
  task :topics => [:environment] do
    DB = Sequel.postgres('curul505', :user => 'jparbros', :host => 'localhost')
    topics = DB[:tags].join(:taggings, :tag_id => :id).select(:name)
    topics.each do |topic|
      unless topic[:name].blank?
        tema = Topic.find_or_create_by_name topic[:name].lstrip
        puts "CREANDO TOPIC => #{tema.name}\n"
      end
    end
  end

  desc "MIGRATE PARTIES"
  task :parties => [:environment] do
    DB = Sequel.postgres('curul505', :user => 'jparbros', :host => 'localhost')
    DB[:parties].each do |party|
      unless party[:name].blank?
        partido = PoliticalParty.find_or_create_by_name party[:name].lstrip
        puts "CREANDO PARTIDO => #{partido.name}\n"
      end
    end
  end

  desc "Migrate Representatives"
  task :representatives => [:environment] do
    DB = Sequel.postgres('curul505', :user => 'jparbros', :host => 'localhost')
    members = DB[:members]
    mapping_ids = []
    ActiveRecord::Base.transaction do
      members.each do |member|
        general_time = Time.now
        rep_time = Time.now
        representative = Representative.new(name: member[:name],
            position: 'Diputado',
            biography: member[:bio],
            birthday: member[:birthdate].to_date,
            twitter: member[:twitter_screen_name],
            district: member[:district_id],
            phone: "56281300 / #{member[:phone_ext].split(',').first.lstrip if member[:phone_ext]}",
            email: member[:email],
            substitute: member[:substitute],
            election_type: member[:election],
            old_commissions: (member[:commission].blank?)? '' : member[:commission][0..254],
            circumscription: member[:district_id],
            region_id: member[:state_id])

        representative.save!



        mapping_ids << {id: representative.id, legacy_id: member[:id]}

        puts "CREANDO REPRESENTANTE (#{Time.now - rep_time}s) => #{representative.name}\n"

        commssion_time = Time.now

        unless member[:commission].blank?
          member[:commission].split(',').each do |commision|
            representative.commissions << Commission.find_or_create_by_name(commision)
          end
        end

        representative.save!

        puts "ASIGNANDO COMISIONES (#{Time.now - commssion_time}s) \n"

        comments_time = Time.now
        DB[:messages].where(:member_id => member[:id]).each do |message|
          representative.comments.new(comment: message[:text],
              author: message[:name],
              email: message[:email],
              approved: true).save!
        end
        puts "CREANDO COMENTARIOS [#{representative.comments.count}] (#{Time.now - comments_time}s)\n"

        bills = DB[:bills]

        bills.where(:member_id => member[:id]).each do |bill|
          bill_time = Time.now
          state = case bill[:status].to_s
            when 'pending' then 'presentation'
            when 'comision' then 'commission'
            when 'pleno' then 'plenary'
            when 'approved' then 'project'
            end

            unless bill[:resolution].nil?
              unless bill[:resolution].blank? && bill[:resolution].size < 10
                state = case bill[:resolution].to_s
                  when /[c|C]omisión/ then 'rejected_by_commission'
                  when /Desechada por la Mesa Directiva/ then 'rejected_by_board'
                  end
                puts "ESTADO => #{state}\n"
              end
            end

          initiative = representative.initiatives.create!(:title => bill[:name],
              :description => bill[:description],
              :presented_at => bill[:date],
              :voted_at => bill[:vote_date],
              :state => state,
              :official_vote_up => bill[:member_votes_for].to_i,
              :official_vote_down => bill[:member_votes_against],
              :official_vote_abstentions => bill[:member_votes_neutral],
              :number => bill[:id].to_i
          )

          puts "CREANDO LEY (#{Time.now - bill_time}s) => #{initiative.title}\n"

          resources_time = Time.now
          DB[:resources].where(:bill_id => bill[:id]).each do |resource|
            initiative.resources.create(name: resource[:name], url: resource[:url])
          end
          puts "CREANDO RECURSOS (#{Time.now - resources_time}s)\n"

          user_votes_for_time  = Time.now
          bill[:user_votes_for].to_i.times.each do
            initiative.votes.create(:vote => 1)
          end

          puts "CREANDO VOTOS A FAVOR (#{Time.now - user_votes_for_time}s)\n"

          user_votes_against_time  = Time.now
          bill[:user_votes_against].to_i.times.each do
            initiative.votes.create(:vote => -1)
          end

          puts "CREANDO VOTOS EN CONTRA (#{Time.now - user_votes_against_time}s)\n"

          user_votes_neutral_time  = Time.now
          bill[:user_votes_neutral].to_i.times.each do
            initiative.votes.create(:vote => 0)
          end

          puts "CREANDO VOTOS NEUTROS (#{Time.now - user_votes_neutral_time}s)\n"

          bill_comments_time = Time.new
          DB[:comments].filter(:commentable_type => 'Bill', :commentable_id => bill[:id]).each do |comment|
            user = DB[:users].where(:id => comment[:user_id]).first
            initiative.comments.create(comment: comment[:comment],
                author: user[:name],
                email: user[:email],
                tendency: (comment[:comment_temperature] == 'positive')? 1 : -1,
                approved: true)
          end
          puts "CREANDO COMENTARIOS (#{Time.now - bill_comments_time}s)\n"
        end
        puts "================================== (#{Time.now - general_time}s) ==================================\n\n\n\n\n"
      end
    end
    puts mapping_ids.inspect
  end
end