class AddCustomLayoutToSite < ActiveRecord::Migration
=begin
  def change
    add_column :sites, :custom_layout, :boolean
    add_column :sites, :custom_layout_content, :text
  end
=end
end
