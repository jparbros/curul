class AddSiteIdToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :site_id, :integer
  end
end
