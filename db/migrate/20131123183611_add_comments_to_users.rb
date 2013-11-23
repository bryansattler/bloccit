class AddCommentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_id, :string
    add_index :users, :user_id
  end
end
