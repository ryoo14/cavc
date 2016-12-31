require 'net/https'
require 'yaml'

module Cavc
  module Logio 
    def self.login

      home = ENV['HOME']
      unless File.exists?("#{home}/.cavconfig")
        puts "Error: please create #{home}/.cavconfig file at yaml"
        exit 1
      end

      conf = YAML.load_file("#{home}/.cavconfig")

      uri = URI::parse('https://not-522.appspot.com/login')

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data({id: conf['id'], password: conf['password']})

      res = https.start do |http|
        https.request(req)
      end

      res["set-cookie"]
    end

    def self.logout(cookie)
      uri = URI::parse('https://not-522.appspot.com/logout')

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Get.new(uri.path)
      req["Cookie"] = cookie
      req["Upgrade-Insecure-Requests"] = "1"

      https.request(req)
    end
  end
end
