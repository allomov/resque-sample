require 'sinatra'
require 'sinatra/activerecord'

puts "the users table doesn't exist" if !database.table_exists?('users')

# models just work ...
class User < ActiveRecord::Base
  attr_accessible :instagram_user_name, :password, :id, :period
  validates :password, :id, presence: true
  validates_uniqueness_of :id
  validates_uniqueness_of :instagram_user_name
end
