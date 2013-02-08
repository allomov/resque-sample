class AddErrorLogToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_error, :text
    add_column :users, :errors_count, :integer, default: 0
  end

  def self.down
  end
end
