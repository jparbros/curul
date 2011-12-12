class AddFieldCircumscriptionToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :circumscription, :string
  end
end
