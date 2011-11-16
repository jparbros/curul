class CreateRepresentatives < ActiveRecord::Migration
  def change
    create_table :representatives do |t|
      t.string :name
      t.string :position
      t.integer :region_id
      t.integer :province_id
      t.string :avatar
      t.text :biography
      t.string :birthday
      t.string :twitter
      t.string :facebook

      t.timestamps
    end
  end
end
