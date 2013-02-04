require 'bundler/setup'
Bundler.require(:default)
require File.expand_path('../lib/user_worker', __FILE__)
require 'sinatra/redis'

configure do
  #uri = URI.parse(ENV["REDISTOGO_URL"])
  #Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  #Resque.redis.namespace = "resque:example"
  #set :redis, ENV["REDISTOGO_URL"]
end

get "/" do

  #@local_uploads = redis.get local_uploads_key
  #@s3_originals = redis.get s3_originals_key
  #@s3_watermarked = redis.get s3_watermarked_key
  #@watermarked_urls = redis.lrange(watermarked_url_list, 0, 4)
  @working = Resque.working
  erb :index
end

post '/users(.:format)' do
  unless params['user'].nil?
    user_hash = params['user']
    Resque.enqueue(UserWorker, user_hash)
  end
end

delete '/users' do

end