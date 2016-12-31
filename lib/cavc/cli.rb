require 'thor'
require 'date'

module Cavc
  class CLI < Thor
    desc 'create', 'create contest'
    def create
      # input info
      opt = Operation.input_contest_info

      p opt
      
      # get token
      #cookie = Logio.login

      # create contest
      #Operation.create(opt, cookie)

      # add contest
      #Operation.add_contest

      # logout
      #Logio.logout(cookie)
    end
  end
end
