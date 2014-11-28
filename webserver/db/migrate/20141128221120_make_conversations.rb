class MakeConversations < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sending_user_id
      t.integer :receiving_user_id
      t.string :data
    end
  end
end
