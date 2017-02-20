require 'net/https'
require 'yaml'

module Cavc
  class Logio 
    attr_accessor :user_id, :password

    def initialize
      home = ENV['HOME']
      unless File.exists?("#{home}/.cavconfig")
        puts "Error: please create #{home}/.cavconfig file at yaml"
        exit 1
      end
      conf = YAML.load_file("#{home}/.cavconfig")

      @user_id = conf['id']
      @password = conf['password']
    end

    def login
      uri = URI::parse('https://not-522.appspot.com/login')

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data({ id: user_id, password: password })

      res = https.request(req)

      res["set-cookie"]
    end

    def logout(token)
      uri = URI::parse('https://not-522.appspot.com/logout')

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Get.new(uri.path)
      req["Cookie"] = token

      https.request(req)
    end
  end
end
