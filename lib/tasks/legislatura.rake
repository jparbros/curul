# encoding: utf-8

namespace :legislatura do
  desc "Legislatura LXII"
  task :LXII => [:environment] do
    Representative.transaction do
      legislatura = Legislature.find_by_name('Legislatura LXII')
      CSV.foreach('doc/legislatura_LXII.csv', :headers => true) do |diputado|
        region = Region.find_by_name(diputado['Entidad'])
        partido = PoliticalParty.find_by_name(diputado['Partido'])
        rep = Representative.create(
          name: "#{diputado['Nombre']} #{diputado['Apellidos']}",
          position: 'Diputado',
          region: region,
          biography: diputado['Bio'],
          twitter: diputado['Twitter'],
          political_party: partido,
          district: diputado['Distrito'],
          phone: "#{diputado['Teléfono']} EXT. #{diputado['Extensión']}",
          email: diputado['Correo electrónico'],
          substitute: "#{diputado['Suplente Nombre']} #{diputado['Suplente Apellido']}",
          election_type: diputado['Tipo de elección'],
          circumscription: diputado['Circunscripción'],
          legislature: legislatura
        )
      end
    end
  end
end