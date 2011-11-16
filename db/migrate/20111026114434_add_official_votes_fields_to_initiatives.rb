class AddOfficialVotesFieldsToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :official_vote_up, :integer, :default => 0
    add_column :initiatives, :official_vote_down, :integer, :default => 0
  end
end
