class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.string :author
      t.boolean :approved
      t.integer :initiative_id

      t.timestamps
    end
  end
end
