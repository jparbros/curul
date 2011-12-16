class CreateOfficialVotes < ActiveRecord::Migration
  def change
    create_table :official_votes do |t|
      t.integer :political_party_id
      t.integer :votes
      t.integer :initiative_id

      t.timestamps
    end
  end
end
