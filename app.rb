require 'bundler/setup'
Bundler.require(:default)
require File.expand_path(File.join('..', 'lib', 'partials'), __FILE__)
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
  @user = User.new
  @users = User.all
  @working = Resque.working
  erb :index
end

post '/users' do
  @users = User.all
  unless params[:user].nil?
    @user = User.new(params[:user])
    if @user.save
      workers = { 'low' => BasicUserWorker, 'normal' => StandardUserWorker, 'high' => PremiumUserWorker }
      priority = params[:user][:priority]
      Resque.enqueue(workers[priority], @user.id)
    end
    erb :index
  end
end

delete '/users' do

end