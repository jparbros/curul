require 'csv'
namespace :representantes do
  desc "Task description"
  task :create => [:environment] do
    CSV.open('doc/representantes.csv', 'r', :col_sep => "\t", :headers => true).each do |representante|
      rep = Representative.new( :name => representante['name'],
          :position => 'Diputado',
          :biography => representante['bio'],
          :district => representante['district'],
          :twitter => representante['twitter'],
          :phone => representante['phone'],
          :election_type => representante['election'],
          :substitute => representante['substitute'],
          :email => representante['email']
      )
      
      image = File.open("../curul505/public#{representante['image'].gsub(/\?.*$/,'')}")
      rep.avatar = image
      rep.political_party = PoliticalParty.find_or_create_by_name representante['party']
      rep.region =  Region.find_by_name representante['state']
      rep.save!
    end
  end
  
  desc "Task description"
  task :update_commissions => [:environment] do
    CSV.open('doc/representantes.csv', 'r', :col_sep => "\t", :headers => true).each do |representante|
      representative = Representative.find_by_name representante['name']
      unless representante['commission'].blank?
        representante['commission'].split(',').each do |commission_name|
          puts commission_name
          commission = Commission.find_or_create_by_name commission_name.lstrip
          representative.commissions << commission
        end
        representative.save!
      end
    end
  end
end

namespace :iniciativas do
  desc "Task description"
  task :create => [:environment] do
    CSV.open('doc/iniciativa_final.csv', 'r', :col_sep => "\t", :headers => true).each do |iniciativa|
      init = Initiative.find_by_id(iniciativa['numero'])
      unless init
        debugger
        ini = Initiative.new(:title => iniciativa['nombre'],
            :description => iniciativa['descripcion'],
            :presented_at => iniciativa['fecha_turno'],
            :voted_at => iniciativa['fecha_votacion'],
            :additional_resources => iniciativa['recursos_adicionales']
        )
        rep = Representative.find_by_name iniciativa['proponente']
        ini.representative = rep if rep
      
        state = case iniciativa['estado'].to_s
          when 'pending' then 'presentation'
          when 'En Comision' then 'commission'
          when 'En Pleno' then 'plenary'
          when 'Aprobada' then 'project'
          when 'Desechada en Comision' then 'rejected_by_commission'
          when 'Desechada por la Mesa Directiva' then 'rejected_by_board'
          end
        ini.state = state
      
        ini.political_party = PoliticalParty.find_by_name iniciativa['partido']
      
        puts iniciativa['tema']
        iniciativa['tema'].split(',').each do |tema|
          topic = Topic.find_or_create_by_name tema
          ini.topics << topic
        end
      
        if iniciativa['comision']
          iniciativa['comision'].split(',').each do |comision|
            commission = Commission.find_or_create_by_name comision
            ini.commissions << commission
          end
        end
      
        ini.save!
      
        # iniciativa[5].to_i.times {
        #         Vote.create(:vote => 1, :initiative_id => ini.id)
        #       }
        #       iniciativa[6].to_i.times {
        #         Vote.create(:vote => -1, :initiative_id => ini.id)
        #       }
      end
    end
  end
  
  desc "Task description"
  task :update_dates => [:environment] do
    CSV.open('doc/iniciativa_final.csv', 'r', :col_sep => "\t", :headers => true).each do |iniciativa|
      init = Initiative.find_by_id(iniciativa['numero'])
      presented_split = iniciativa['fecha_turno'].split('/')
      presented_at = (presented_split[1].to_i > 12)? "20#{presented_split[2]}/#{presented_split[0]}/#{presented_split[1]}" : "20#{presented_split[2]}/#{presented_split[1]}/#{presented_split[0]}"
      init.presented_at = presented_at
      if iniciativa['fecha_votacion']
        voted_split = iniciativa['fecha_turno'].split('/')
        voted_at = (voted_split[1].to_i > 12)? "20#{voted_split[2]}/#{voted_split[0]}/#{voted_split[1]}" : "20#{voted_split[2]}/#{voted_split[1]}/#{voted_split[0]}"
        init.voted_at = voted_at
      end
      init.save!
    end
  end
end

namespace :commission do
  desc "Task description"
  task :update => [:environment] do
    Commission.delete_all
    
    CSV.open('doc/representantes.csv', 'r', :col_sep => "\t", :headers => true).each do |representante|
      rep = Representative.find_by_name(representante['name'])
      rep.commissions = []
      if representante['commission']
        representante['commission'].split(',').each do |commission|
          commission = Commission.find_or_create_by_name commission.strip
          rep.commissions << commission
        end
      end
    end
    
  end
end

namespace :seeds do
  desc "Task description"
  task :permissions => [:environment] do
    Permission.create(subject_class: Comment.name, action: :read) unless Permission.find_by_subject_class_and_action('Comment','read')
    Permission.create(subject_class: Comment.name, action: :manage) unless Permission.find_by_subject_class_and_action('Comment','manage')
    Permission.create(subject_class: Comment.name, action: :destroy) unless Permission.find_by_subject_class_and_action('Comment','destroy')
    
    Permission.create(subject_class: Commission.name, action: :read) unless Permission.find_by_subject_class_and_action('Commission','read')
    Permission.create(subject_class: Commission.name, action: :manage) unless Permission.find_by_subject_class_and_action('Commission','manage')
    Permission.create(subject_class: Commission.name, action: :destroy) unless Permission.find_by_subject_class_and_action('Commission','destroy')
    
    Permission.create(subject_class: Initiative.name, action: :read) unless Permission.find_by_subject_class_and_action('Initiative','read')
    Permission.create(subject_class: Initiative.name, action: :manage) unless Permission.find_by_subject_class_and_action('Initiative','manage')
    Permission.create(subject_class: Initiative.name, action: :destroy) unless Permission.find_by_subject_class_and_action('Initiative','destroy')
    
    Permission.create(subject_class: Legislature.name, action: :read) unless Permission.find_by_subject_class_and_action('Legislature','read')
    Permission.create(subject_class: Legislature.name, action: :manage) unless Permission.find_by_subject_class_and_action('Legislature','manage')
    Permission.create(subject_class: Legislature.name, action: :destroy) unless Permission.find_by_subject_class_and_action('Legislature','destroy')

    Permission.create(subject_class: PoliticalParty.name, action: :read) unless Permission.find_by_subject_class_and_action('PoliticalParty','read')
    Permission.create(subject_class: PoliticalParty.name, action: :manage) unless Permission.find_by_subject_class_and_action('PoliticalParty','manage')
    Permission.create(subject_class: PoliticalParty.name, action: :destroy) unless Permission.find_by_subject_class_and_action('PoliticalParty','destroy')

    Permission.create(subject_class: Region.name, action: :read) unless Permission.find_by_subject_class_and_action('Region','read')
    Permission.create(subject_class: Region.name, action: :manage) unless Permission.find_by_subject_class_and_action('Region','manage')
    Permission.create(subject_class: Region.name, action: :destroy) unless Permission.find_by_subject_class_and_action('Region','destroy')

    Permission.create(subject_class: Representative.name, action: :read) unless Permission.find_by_subject_class_and_action('Representative','read')
    Permission.create(subject_class: Representative.name, action: :manage) unless Permission.find_by_subject_class_and_action('Representative','manage')
    Permission.create(subject_class: Representative.name, action: :destroy) unless Permission.find_by_subject_class_and_action('Representative','destroy')

    Permission.create(subject_class: Topic.name, action: :read) unless Permission.find_by_subject_class_and_action('Topic','read')
    Permission.create(subject_class: Topic.name, action: :manage) unless Permission.find_by_subject_class_and_action('Topic','manage')
    Permission.create(subject_class: Topic.name, action: :destroy) unless Permission.find_by_subject_class_and_action('Topic','destroy')
    
    Permission.create(subject_class: User.name, action: :read) unless Permission.find_by_subject_class_and_action('User','read')
    Permission.create(subject_class: User.name, action: :manage) unless Permission.find_by_subject_class_and_action('User','manage')
    Permission.create(subject_class: User.name, action: :destroy) unless Permission.find_by_subject_class_and_action('User','destroy')

  end
end