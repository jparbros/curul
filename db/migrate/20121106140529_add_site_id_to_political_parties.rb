class AddSiteIdToPoliticalParties < ActiveRecord::Migration
  def change
    add_column :political_parties, :site_id, :integer
  end
end
