require 'sinatra'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  attr_accessible :instagram_user_name, :password, :id, :period

  validates_presence_of :password
  validates_presence_of :id

  validates_uniqueness_of :id
  validates_uniqueness_of :instagram_user_name
end
