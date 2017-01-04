require 'thor'
require 'date'

module Cavc
  class CLI < Thor
    desc 'create', 'create contest'
    def create
      # input info
      opt = Operation.input_contest_info
      
      # get token
      cookie = Logio.login

      # create contest
      contest_page = Operation.create_contest(opt, cookie)

      # input info on probrem to add to contest
      problem_list = Operation.input_problem_info

      # add contest
      Operation.add_contest(contest_page, problem_list, cookie)

      # logout
      Logio.logout(cookie)
    end
  end
end
