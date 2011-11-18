
namespace :representantes do
  desc "Task description"
  task :create => [:environment] do
    CSV.open('doc/representantes.csv', 'r', :col_sep => "\t", :headers => true).each do |representante|
      rep = Representative.new( :name => "#{representante['Nombre']} #{representante['Apellidos']}",
          :position => 'Diputado',
          :biography => representante['Bio'],
          :district => representante['Distrito'],
          :twitter => representante['Twitter'],
          :phone => "#{representante['Telefono']} Ext. #{representante['Extension']}",
          :commissions => representante['Comisiones'],
          :election_type => representante['Tipo de eleccion']
      )
      rep.political_party = PoliticalParty.find_or_create_by_name representante['Partido']
      rep.region =  Region.find_by_name representante['Entidad']
      rep.save
    end
  end
end

namespace :iniciativas do
  desc "Task description"
  task :create => [:environment] do
    CSV.open('doc/iniciativas.csv', 'r', :col_sep => "\t").each do |iniciativa|
      ini = Initiative.new(:title => iniciativa[0],
          :description => iniciativa[1],
          :presented_at => iniciativa[2],
          :official_vote_up => iniciativa[3],
          :official_vote_down => iniciativa[4],
      )
      rep = Representative.find_by_name iniciativa[8]
      ini.representative = rep if rep
      puts iniciativa[7].to_s
      state = case iniciativa[7].to_s
        when 'pending' then 'presentation'
        when 'comision' then 'commission'
        when 'pleno' then 'plenary'
        when 'approved' then 'project'
        end
      puts state
      ini.state = state
      puts ini.inspect
      ini.save!
      iniciativa[5].to_i.times {
        Vote.create(:vote => 1, :initiative_id => ini.id)
      }
      iniciativa[6].to_i.times {
        Vote.create(:vote => -1, :initiative_id => ini.id)
      }
    end
  end
end