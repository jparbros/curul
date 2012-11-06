class AddSiteIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :site_id, :integer
  end
end
