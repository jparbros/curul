require 'CSV'

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