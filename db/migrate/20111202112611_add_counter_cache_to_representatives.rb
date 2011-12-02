class AddCounterCacheToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :comments_count, :integer, :default => 0
    add_column :initiatives, :comments_count, :integer, :default => 0
    Representative.all.each do |representative|
      Representative.reset_counters(representative.id, :comments)
    end
    
    Initiative.all.each do |initiative|
      Initiative.reset_counters(initiative.id, :comments)
    end
  end
end
