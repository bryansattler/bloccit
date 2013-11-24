class AddCommentsToUsers < ActiveRecord::Migration
  def change
    add_column :comments, :users, :user_id, :integer
    add_index :users, :user_id
  end
end
