class AddDeviceIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :device_id, :string
  end

  def self.down
  end
end
