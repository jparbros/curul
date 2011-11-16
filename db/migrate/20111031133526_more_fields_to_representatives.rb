class MoreFieldsToRepresentatives < ActiveRecord::Migration
  def up
    add_column :representatives, :phone, :string
    add_column :representatives, :email, :string
    add_column :representatives, :substitute, :string
    add_column :representatives, :election_type, :string
    add_column :representatives, :commissions, :string
  end

  def down
    remove_column :representatives, :phone
    remove_column :representatives, :email
    remove_column :representatives, :substitute
    remove_column :representatives, :election_type
    remove_column :representatives, :commissions
  end
end