require 'resque'

module BuildAndDistributeJob
  @queue = :default

  def self.perform params
    File.open('/Users/inderpal/ips.rb', 'w') { |file| file.write("aaa") }
    puts "IPS"
  end
end
