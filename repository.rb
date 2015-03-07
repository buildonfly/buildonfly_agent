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

  def self.setup url
    file = File.open( "repository.info", "w" )
    file << url
    file.close

    repo= self.new
    repo.clone
    repo
  end
end
