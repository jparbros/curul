class AddPoliticalPartyIdToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :political_party_id, :integer
  end
end
