class AddLegislatureToIniciatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :legislature_id, :integer
  end
end
