require 'net/https'

module Cavc
  class Contest
    attr_accessor :basic_info, :problem_info

    def initialize(basic_info, problem_info)
      @basic_info = basic_info
      @problem_info = problem_info
    end

    def create_contest(token)
      uri = URI::parse('https://not-522.appspot.com/coordinate')

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Post.new(uri.path)
      req['Cookie'] = token

      req.set_form_data({
        title: basic_info['title'],
        start_day: basic_info['start_day'],
        start_hour: basic_info['start_hour'].to_s,
        start_minute: basic_info['start_minute'].to_s,
        end_day: basic_info['end_day'],
        end_hour: basic_info['end_hour'].to_s,
        end_minute: basic_info['end_minute'].to_s,
        penalty: basic_info['penalty'].to_s,
        private: basic_info['private']
      })

      res = https.start do |http|
        https.request(req)
      end

      res['location']
    end

    def add_problem(contest_url, token)
      uri = URI::parse("#{contest_url}/add_problem")

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Post.new(uri.path)
      req['Cookie'] = token

      problem_info.each do |n|
        req.set_form_data({
          url: n
        })

        https.request(req)
        sleep 3
      end
    end
  end
end
