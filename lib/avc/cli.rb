require 'thor'
require 'date'

module Avc
  class CLI < Thor
    desc 'create [TITLE] -sd [yy/mm/dd] -st [hh:mm] -ed [yy/mm/dd] -et [hh:mm]'
    option :title, type: :string, alias: [-sd], required: :true desc: "test"
    option :start_day, type: :string, default: Date.today.strftime("%Y/%m/%d"), alias: [-sd]
    def create
      puts options[:title]
      puts options[:start_day]
    end
end

    # title
    # start_day
    # start_hour
    # start_minute
    # end_day
    # end_hour
    # end_minitue
    # penalty
    # private
