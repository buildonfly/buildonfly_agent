class GitLog
  def initialize raw_data
    fields = raw_data.split("+0+")
    @commit_id = fields[0]
    @message = fields[1]
    @date = fields[2]
  end

  def self.all raw_data
    git_logs = []
    raw_data.split("\n").each do |row|
      git_logs << self.new(row)
    end
    git_logs
  end

  def to_h
    {
      commit_id: @commit_id,
      message: @message,
      date: @date
    }
  end
end
