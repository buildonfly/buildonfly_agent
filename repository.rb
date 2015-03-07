require './git_log'
class Repository

  def initialize
    @url = File.read('repository.info')
  end

  def name
    @url.split("/").last.split(".git").first
  end

  def dir
    "repos/#{name}"
  end

  def clone
    unless File.directory?(dir)
      FileUtils.mkdir_p 'repos'
      Cocaine::CommandLine.new("cd repos; git clone #{@url}").run
    end
  end

  def pull
    Cocaine::CommandLine.new("cd #{dir}; git reset --hard; git pull").run
  end

  def logs page_num
    GitLog.all(Cocaine::CommandLine.new("cd #{dir}; #{log_message(page_num)}").run)
  end

  def self.setup url
    file = File.open( "repository.info", "w" )
    file << url
    file.close

    repo= self.new
    repo.clone
    repo
  end

  private
  def log_message page_num
    skip = (page_num-1)*10
    "git log -n 10 --pretty=format:%H+0+%s+0+%at --skip=#{skip}"
  end
end
