class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      # id, instagram user_name, password, and actions/hour
      t.integer :id
      t.string  :instagram_user_name
      t.string  :password
      t.integer :period      # updates in millis
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
