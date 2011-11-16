class AddRepresentativeIdToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :representative_id, :integer
  end
end
