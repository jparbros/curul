class CreateInitiativesTopics < ActiveRecord::Migration
  def up
    create_table :initiatives_topics, :id => false do |t|
      t.integer :initiative_id
      t.integer :topic_id
    end
  end

  def down
    drop_table :initiatives_topics
  end
end