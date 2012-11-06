class AddSiteIdToOfficialVotes < ActiveRecord::Migration
  def change
    add_column :official_votes, :site_id, :integer
  end
end
