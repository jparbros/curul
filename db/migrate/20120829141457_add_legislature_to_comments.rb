class AddLegislatureToComments < ActiveRecord::Migration
  def change
    add_column :comments, :legislature_id, :integer
  end
end
