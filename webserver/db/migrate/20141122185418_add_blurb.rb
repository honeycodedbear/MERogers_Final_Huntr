class AddBlurb < ActiveRecord::Migration
  def change
    add_column :users, :blurb, :string
  end
end
