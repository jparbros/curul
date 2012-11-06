class AddSiteIdToLegislatures < ActiveRecord::Migration
  def change
    add_column :legislatures, :site_id, :integer
  end
end
