module Cavc
  module Util
    def self.conf_exist?
      flag = true
      home = ENV['HOME']
      unless File.exists?("#{home}/.cavconfig")
        flag = false
      end

      flag
    end
  end
end
