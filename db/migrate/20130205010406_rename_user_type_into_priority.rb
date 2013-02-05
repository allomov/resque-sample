class RenameUserTypeIntoPriority < ActiveRecord::Migration
  def self.up
    rename_column :users, :type, :priority
  end

  def self.down
  end
end
