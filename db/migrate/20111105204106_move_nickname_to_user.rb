class MoveNicknameToUser < ActiveRecord::Migration
  def up
    add_column :users, :name, :string
    remove_column :members, :nickname
  end

  def down
    remove_column :users, :name
    add_column :members, :nickname, :string
  end
end
