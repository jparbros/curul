class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.text :name
      t.text :url
      t.integer :initiative_id

      t.timestamps
    end
  end
end
