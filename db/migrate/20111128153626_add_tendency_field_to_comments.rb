class AddTendencyFieldToComments < ActiveRecord::Migration
  def change
    add_column :comments, :tendency, :integer
  end
end
