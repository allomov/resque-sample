class AddTypeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :type, :string, default: 'low'
  end

  def self.down
  end
end
