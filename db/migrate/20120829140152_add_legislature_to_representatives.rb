class AddLegislatureToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :legislature_id, :integer
  end
end
