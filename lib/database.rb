require 'sinatra'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  attr_accessible :instagram_user_name, :password, :user_id, :period, :priority

  def login

  end

  # getting segfault with validation
  #validates_presence_of :password
  #validates_presence_of :user_id
  #
  #validates_uniqueness_of :user_id
  #validates_uniqueness_of :instagram_user_name
end
