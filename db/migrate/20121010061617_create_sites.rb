class CreateSites < ActiveRecord::Migration

  def change
    create_table :sites do |t|
      t.string :name
      t.string :host
      t.string :path
      t.string :locale

      t.timestamps
    end
  end

end
