class AddCounterCacheToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :comments_count, :integer, :default => 0
    add_column :initiatives, :comments_count, :integer, :default => 0
  end
end
