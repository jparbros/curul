class AddDistrictToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :district, :string
  end
end
