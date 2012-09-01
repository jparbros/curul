class CreateLegislatures < ActiveRecord::Migration
  def change
    create_table :legislatures do |t|
      t.string :name
      t.boolean :active, :default => false

      t.timestamps
    end
  end
end
