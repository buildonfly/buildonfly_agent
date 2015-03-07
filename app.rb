require 'pry'
require 'bundler'
require 'resque'
require 'redis'
require './build_and_distribute_job'
require './repository'

Bundler.require

Resque.redis = Redis.new

post '/generate' do
  content_type :json
  Resque.enqueue(BuildAndDistributeJob, {})
  {id: '123'}.to_json
end

get '/logs' do
  content_type :json
  if params[:page_num]
    page_num = params[:page_num].to_i
  else
    page_num = 1
  end
  repository = Repository.new
  git_logs = repository.logs page_num
  git_logs.map{|l| l.to_h}.to_json
end

def create_file filename, content
  File.open(filename, 'w') { |file| file.write(content) }
end


