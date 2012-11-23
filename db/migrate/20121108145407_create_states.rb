class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.text :description
      t.integer :site_id

      t.timestamps
    end
  end
end
