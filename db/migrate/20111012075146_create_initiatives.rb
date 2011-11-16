class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.timestamp :presented_at
      t.text :description
      t.text :title
      t.string :presented_by
      t.text :additional_resources
      t.string :additional_resources_url

      t.timestamps
    end
  end
end
