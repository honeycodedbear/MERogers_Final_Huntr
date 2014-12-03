class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :userA_id
      t.integer :userB_id
    end
  end
end
