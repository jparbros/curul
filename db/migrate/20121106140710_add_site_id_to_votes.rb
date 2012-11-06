class AddSiteIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :site_id, :integer
  end
end
