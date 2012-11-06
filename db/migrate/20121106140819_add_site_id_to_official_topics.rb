class AddSiteIdToOfficialTopics < ActiveRecord::Migration
  def change
    add_column :topics, :site_id, :integer
  end
end
