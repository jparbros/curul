class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.string :secret
      t.string :token

      t.timestamps
    end
  end
end
