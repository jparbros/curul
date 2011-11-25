class AddFieldsToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :voted_at, :datetime
    add_column :initiatives, :official_vote_abstentions, :integer
  end
end
