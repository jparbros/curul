class AddMainFieldToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :main, :boolean
  end
end
