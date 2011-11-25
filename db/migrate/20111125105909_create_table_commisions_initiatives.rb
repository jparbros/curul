class CreateTableCommisionsInitiatives < ActiveRecord::Migration
  def up
    create_table :commissions_initiatives, :id => false do |t|
      t.integer :commission_id
      t.integer :initiative_id
    end
  end

  def down
    drop_table :commissions_initiatives
  end
end