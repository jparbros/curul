class AddSubdomainToSites < ActiveRecord::Migration
  def change
    add_column :sites, :subdomain, :string
  end
end
