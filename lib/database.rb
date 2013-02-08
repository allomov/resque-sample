require 'sinatra'
require 'sinatra/activerecord'
require './lib/path_helper'
require File.expand_path(File.join('..', 'path_helper'), __FILE__)

KEY = "IMyYiubXP5Jx5lTLdVLWQZjeLEuA3WPnE4xyvVGY+bnaRcVsRjtV3jEAzJ/jwAme"

class User < ActiveRecord::Base

  before_save :generate_device_id

  attr_accessible :instagram_user_name, :password, :user_id, :period, :priority, :device_id

  def login

    login_info = { :username  => self.instagram_user_name,
                   :password  => self.password,
                   :device_id => self.device_id }.to_json
    checksum = Digest::HMAC.hexdigest(login_info, KEY, Digest::SHA256)
    signed_body = "#{checksum}.#{login_info}"
    post_data = {:signed_body => signed_body, :ig_sig_key_version => 2}

    @session = Patron::Session.new
    @session.base_url = base_url
    @session.handle_cookies(nil)
    @session.headers["User-Agent"] = USER_AGENT
    @session.post(login_path, post_data)

  end

  def generate_device_id
    self.update_attribute(:device_id, SecureRandom.uuid)
  end

  def popular
    if @session
      json = JSON.parse(@session.get(popular_path).body)
      json['items'].map { |i| InstagramImage.new(i['id'], i['user']) }
    else
      []
    end
  end

  # getting segfault with validation
  #validates_presence_of :password
  #validates_presence_of :user_id
  #
  #validates_uniqueness_of :user_id
  #validates_uniqueness_of :instagram_user_name
end
