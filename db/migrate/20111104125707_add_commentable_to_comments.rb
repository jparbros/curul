class AddCommentableToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
    remove_column :comments, :initiative_id
  end
end
