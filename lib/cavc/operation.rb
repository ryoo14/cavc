require 'net/https'

module Cavc
  module Operation
    def self.input_contest_info
      # input info
      opt = Input.input_info
    end

    def self.create(opt, cookie)

      # create request
      uri = URI::parse('https://not-522.appspot.com/coordinate')

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Post.new(uri.path)
      req['Cookie'] = cookie
      req["Upgrade-Insecure-Requests"] = "1"

      req.set_form_data({
        title: opt['title'],
        start_day: opt['start_day'],
        start_hour: opt['start_hour'].to_s,
        start_minute: opt['start_minute'].to_s,
        end_day: opt['end_day'],
        end_hour: opt['end_hour'].to_s,
        end_minute: opt['end_minute'].to_s,
        penalty: opt['penalty'].to_s,
        private: opt['private']
      })

      res = https.start do |http|
        https.request(req)
      end

      res.code
      res.body
      res.each do |n|
        p n
      end
    end

    def self.add_contest
    end
  end
end

#/setting/4888638647173120/add_problem
