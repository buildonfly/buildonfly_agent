require 'resque'
require './repository'

class RepositorySetupJob
  @queue = :buildonfly_queue

  def self.perform(params)
    Repository.setup params['url']
  end
end
