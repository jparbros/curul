class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :name
      t.integer :region_id

      t.timestamps
    end
  end
end
