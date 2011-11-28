class MigrateCommissions < ActiveRecord::Migration
  def up
    rename_column :representatives, :commissions, :old_commissions
    create_table :commissions_representatives, :id => false do |t|
      t.integer :commission_id
      t.integer :representative_id
    end
  end

  def down
  end
end