class AddSiteIdToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :site_id, :integer
  end
end
