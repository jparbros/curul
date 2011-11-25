class AddPoliticalPartyIdToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :political_party_id, :integer
  end
end
