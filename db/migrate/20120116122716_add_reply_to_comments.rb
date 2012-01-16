class AddReplyToComments < ActiveRecord::Migration
  def change
    add_column :comments, :reply_to, :integer
  end
end
