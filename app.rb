require 'bundler/setup'
Bundler.require(:default)
require File.expand_path(File.join('..', 'lib', 'database'), __FILE__)
%w(premium_user_worker standard_user_worker basic_user_worker).each do |w|
  require File.expand_path(File.join('..', 'lib', 'workers', w), __FILE__)
end

require 'sinatra/redis'

configure do
  #uri = URI.parse(ENV["REDISTOGO_URL"])
  #Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  #Resque.redis.namespace = "resque:example"
  #set :redis, ENV["REDISTOGO_URL"]
end

get "/" do
  @users = User.all
  @working = Resque.working
  erb :index
end

post '/users(.:format)' do
  unless params[:user].nil?
    user = User.new(params[:user])
    if user.save
      Resque.enqueue(params[:user][:type].constantize, user.id)
    end
  end
end

delete '/users' do

end