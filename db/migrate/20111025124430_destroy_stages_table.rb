class DestroyStagesTable < ActiveRecord::Migration
  def up
    drop_table :stages
  end

  def down
  end
end
