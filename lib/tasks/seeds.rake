namespace :congresistas do
  desc "Task description"
  task :create => [:environment] do
    CSV.open('doc/congresistas.csv','r', :col_sep => "\t").each do |congresista|
      hp = Hpricot(open(congresista[6]))
      puts congresista[6]
      image = hp.search('img#ctl00_ContentPlaceHolder1_cabecera1_img_Foto').attr('src').gsub('../','')
      region = hp.search('span#ctl00_ContentPlaceHolder1_cabecera1_LblRegion').inner_text.downcase
      province = hp.search('span#ctl00_ContentPlaceHolder1_cabecera1_LblProvincia').inner_text.downcase
      district = hp.search('span#ctl00_ContentPlaceHolder1_cabecera1_LblDistrito').inner_text.downcase
      rep = Representative.new( :name => congresista[1],
        :position => congresista[2],
        :biography => congresista[6] + "\n" + congresista[7],
        :birthday => congresista[3],
        :district => district
      )
      rep.region =  Region.find_by_name region
      rep.province =  Province.find_by_name province
      rep.remote_avatar_url = "http://www.infogob.com.pe/#{image}"
      rep.political_party = PoliticalParty.find_or_create_by_name congresista[5]
      rep.save
    end
  end
end

namespace :partidos do
  desc "Task description"
  task :create => [:environment] do
    CSV.open('doc/partidos.csv','r', :col_sep => "\t").each do |partido|
      pp = PoliticalParty.new(:name => partido[0])
      #(partido[1].match /doc/)? pp.logo = File.open(partido[1]) : pp.remote_logo_url = partido[1]
      pp.save
    end
  end
end

namespace :iniciativas do
  desc "Task description"
  task :create => [:environment] do
    CSV.open('doc/iniciativas.csv','r', :col_sep => "\t").each do |iniciativa|
      ini = Initiative.new
      presented_at = iniciativa[0].split('/')
      puts "20#{presented_at[2]}/#{presented_at[1]}/#{presented_at[0]}"
      ini.presented_at = (presented_at[1].to_i > 11)? "20#{presented_at[2]}/#{presented_at[0]}/#{presented_at[1]}" : "20#{presented_at[2]}/#{presented_at[1]}/#{presented_at[0]}"
      ini.title = iniciativa[1]
      ini.description = iniciativa[2]
      ini.representative = Representative.find(iniciativa[3])
      ini.state = 'new'
      ini.save
    end
  end
end