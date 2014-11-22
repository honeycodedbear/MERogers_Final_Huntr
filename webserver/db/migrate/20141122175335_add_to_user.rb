class AddToUser < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :dev_type, :string
  end
end
