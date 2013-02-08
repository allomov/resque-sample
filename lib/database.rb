require 'sinatra'
require 'sinatra/activerecord'
require './lib/path_helper'
require File.expand_path(File.join('..', 'path_helper'), __FILE__)

KEY = "IMyYiubXP5Jx5lTLdVLWQZjeLEuA3WPnE4xyvVGY+bnaRcVsRjtV3jEAzJ/jwAme"
USER_AGENT = "Instagram 3.2.0 Android (10/2.3.7; 240dpi; 480x800; HTC/htc_wwe; HTC Desire"

def build_post_data(hash)
  info        = hash.to_json
  checksum    = Digest::HMAC.hexdigest(info, KEY, Digest::SHA256)
  signed_body = "#{checksum}.#{info}"
  post_data   = { :signed_body => signed_body, :ig_sig_key_version => 2 }
end

class InstagramImage

  attr_accessor :image_id, :user_id, :image_info

  def initialize(session, image_info)
    @image_info = image_info
    @image_id, @user_id = image_info['id'], image_info['user']['pk']
    @session = session
  end

  def comment(text)
    post_data = build_post_data({comment: text})
    @session.post(comment_path(@image_id), post_data)
  end

  def like
    post_data = build_post_data({media_id: @image_id})
    @session.post(like_path(@image_id), post_data)
  end

  def follow_author
    post_data = build_post_data({user_id: @user_id})
    @session.post(follow_user(@user_id), post_data)
  end

end

class User < ActiveRecord::Base

  before_save :generate_device_id

  attr_accessible :instagram_user_name, :password, :user_id, :period, :priority, :device_id

  def login

    login_info = { :username  => self.instagram_user_name,
                   :password  => self.password,
                   :device_id => self.device_id }.to_json
    post_data =  build_post_data(login_info)

    @session = Patron::Session.new
    @session.base_url = base_url
    @session.handle_cookies(nil)
    @session.headers["User-Agent"] = USER_AGENT
    @session.post(login_path, post_data)
  end

  def generate_device_id
    self.device_id = SecureRandom.uuid
  end

  def popular
    @popual_feed ||= if @session
      json = JSON.parse(@session.get(popular_path).body)
      json['items'].map { |image_info| InstagramImage.new(@session, image_info) }
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
