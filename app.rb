require 'pry'
require 'bundler'
require 'resque'
require 'redis'
require './build_and_distribute_job'

Bundler.require

Resque.redis = Redis.new

post '/generate' do
  content_type :json
  Resque.enqueue(BuildAndDistributeJob, {})
  {id: '123'}.to_json
end

def create_file filename, content
  File.open(filename, 'w') { |file| file.write(content) }
end


