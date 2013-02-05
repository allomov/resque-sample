class RenameUserIdToUserId < ActiveRecord::Migration
  def self.up
    add_column :users, :user_id, :integer
  end

  def self.down
  end
end
