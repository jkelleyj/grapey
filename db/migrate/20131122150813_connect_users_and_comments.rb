class ConnectUsersAndComments < ActiveRecord::Migration
  def up
    add_column :comments, :user_id, :integer
    remove_column :comments, :username
  end

  def down
    remove_column :comments, :user_id
    add_column :comments, :username, :string
  end
end
