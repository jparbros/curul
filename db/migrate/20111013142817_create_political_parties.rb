class CreatePoliticalParties < ActiveRecord::Migration
  def change
    create_table :political_parties do |t|
      t.string :name
      t.string :logo

      t.timestamps
    end
  end
end
