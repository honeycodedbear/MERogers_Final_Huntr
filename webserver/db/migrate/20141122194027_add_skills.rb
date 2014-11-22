class AddSkills < ActiveRecord::Migration
  def change
    add_column :users, :github, :string
    add_column :users, :personal, :string
    add_column :users, :skill1, :string
    add_column :users, :skill2, :string
    add_column :users, :skill3, :string
    add_column :users, :skill4, :string
    add_column :users, :skill5, :string
    add_column :users, :skill6, :string
    add_column :users, :employer, :string
  end
end
