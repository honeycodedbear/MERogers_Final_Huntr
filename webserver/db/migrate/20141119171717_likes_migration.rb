class LikesMigration < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :userA
      t.integer :userB
      t.boolean :likes?
    end
  end
end
