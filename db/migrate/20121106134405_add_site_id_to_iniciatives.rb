class AddSiteIdToIniciatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :site_id, :integer
  end
end
