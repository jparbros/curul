class AddSiteIdToCommissions < ActiveRecord::Migration
  def change
    add_column :commissions, :site_id, :integer
  end
end
