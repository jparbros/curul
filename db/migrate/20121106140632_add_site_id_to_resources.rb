class AddSiteIdToResources < ActiveRecord::Migration
  def change
    add_column :resources, :site_id, :integer
  end
end
