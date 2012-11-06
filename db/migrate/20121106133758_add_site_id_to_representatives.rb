class AddSiteIdToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :site_id, :integer
  end
end
