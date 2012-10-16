class AddSexToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :sex, :string
    add_column :representatives, :first_name, :string
    add_column :representatives, :last_name, :string
    Representative.all.each do |representative|
      name = representative.name.split(' ')
      if name.size == 3
        representative.first_name = name[0]
        representative.last_name = "#{name[1]} #{name[2]}"
      elsif name.size == 5
        representative.first_name = "#{name[0]} #{name[1]} #{name[2]}"
        representative.last_name = "#{name[3]} #{name[4]}"
      elsif name.size == 6
        representative.first_name = "#{name[0]} #{name[1]} #{name[2]} #{name[3]}"
        representative.last_name = "#{name[4]} #{name[5]}"
      else
        representative.first_name = "#{name[0]} #{name[1]}"
        representative.last_name = "#{name[2]} #{name[3]}"
      end
      puts representative.id
      representative.save
    end
    remove_column :representatives, :name
  end
end
