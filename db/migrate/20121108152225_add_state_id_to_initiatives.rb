class AddStateIdToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :state_id, :integer
  end
end
