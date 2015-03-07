class Repository

  def initialize
    @url = Cocaine::CommandLine.new("cat repository.info").run
  end

  def name
    @url.split("/").last.split(".git").first
  end

  def clone
    unless File.directory?(name)
      Cocaine::CommandLine.new("git clone #{@url}").run
    end
  end

  def pull
    Cocaine::CommandLine.new("cd #{name}; git reset --hard; git pull").run
  end

  def self.setup url
    Cocaine::CommandLine.new("echo '#{url}' > repository.info").run
    repo= self.new
    repo.clone
    repo
  end
end
