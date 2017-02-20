require 'thor'
require 'date'

module Cavc
  class CLI < Thor
    desc 'create', 'create contest'
    def create
      # check to exist config file
      if Cavc::Util.conf_exist?
        # get token
        logio = Logio.new
        token = logio.login
      else
        puts "Error: Please create #{ENV['HOME']}/.cavconfig"
        exit 1
      end

      # input contest info
      basic_info = Contest::Input.basic_info
      problem_info = Contest::Input.problem_info
      contest = Contest.new(basic_info, problem_info)
      sleep 3

      # create contest
      contest_url = contest.create_contest(token)

      # add problem to contest
      contest.add_problem(contest_url, token)

      # logout
      logio.logout(token)
    end
  end
end
