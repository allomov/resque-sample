require 'bundler/setup'
Bundler.require(:default)

require './app'
require 'resque/tasks'
require 'sinatra/activerecord/rake'

task "resque:setup" do
  ENV['QUEUE'] = '*'
end

task "jobs:work" => "resque:work"