class AddNumberToInitiativesTable < ActiveRecord::Migration
  def change
    add_column :initiatives, :number, :string
  end
end
