class AddCounterToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :counter, :integer, :default => 0
  end

  def self.down
    remove_column :users
  end
end
