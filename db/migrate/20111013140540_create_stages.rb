class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :name
      t.integer :position
      t.string :background

      t.timestamps
    end
  end
end
