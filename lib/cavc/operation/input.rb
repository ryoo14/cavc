require 'date'

module Cavc
  module Operation
    module Input
      def self.input_info
        opt = {}

        puts "作成するコンテストの情報を入力してください。"

        print "タイトル: "
        opt['title'] = STDIN.gets.chomp
        
        print "開始日(yyyy/mm/dd) 空enterで今日日付: "
        tmp = STDIN.gets.chomp
        if tmp == ""
          opt['start_day'] = Date.today.strftime("%Y/%m/%d")
        else
          opt['start_day'] = tmp
        end

        print "終了日(yyyy/mm/dd) 空enterで今日日付: "
        tmp = STDIN.gets.chomp
        if tmp == ""
          opt['end_day'] = Date.today.strftime("%Y/%m/%d")
        else
          opt['end_day'] = tmp
        end

        Check.check_day(opt['start_day'], opt['end_day'])

        print "開始時間(hh:mm): "
        st = STDIN.gets.chomp
        # ガバガバすぎるしTimeとかでいい感じの探したほうがいい
        if st == "" || st !~ /^[0-2]?[0-9]:[0-5]?[0-9]$/
          puts "入力値が不正です"
          exit 1
        end

        print "終了時間(hh:mm): "
        et = STDIN.gets.chomp
        # ガバガバすぎるしTimeとかでいい感じの探したほうがいい
        if et == "" || et !~ /[0-2]?[0-9]:[0-5]?[0-9]/
          puts "入力値が不正です"
          exit 1
        end

        Check.check_time(opt['start_day'], opt['end_day'], st, et)

        opt['start_hour'], opt['start_minute'], opt['end_hour'], opt['end_minute'] = reshape_time(st, et)

        print "ペナルティ(minute) 空enterで5分: "
        tmp = STDIN.gets.chomp
        if tmp == ""
          opt['penalty'] = "5"
        else
          opt['penalty'] = tmp
        end

        print "非公開設定([t|true] or [f|false]) 空enterでtrue"
        tmp = STDIN.gets.chomp
        if tmp == "" || tmp == "t" || tmp == "true"
          opt['private'] = "true"
        elsif tmp == "f" || tmp == "false"
          opt['private'] = "false"
        else
          puts "入力値が不正です"
          exit 1
        end

        opt
      end

      private

      def self.reshape_time(st, et)
        # reshape parameter
        # 日とか時間の繰り上がりを全く考慮に入れていなくてやばそう
        start_hour, start_minute = st.split(':').map(&:to_i)
        end_hour, end_minute = et.split(':').map(&:to_i)

        if start_minute % 5 == 0
          start_minute = start_minute
        else
          start_minute = start_minute + (5 - start_minute % 5)
        end

        if end_minute % 5 == 0
          end_minute = end_minute
        else
          end_minute = end_minute + (5 - end_minute % 5)
        end

        [start_hour.to_s, start_minute.to_s, end_hour.to_s, end_minute]
      end
    end
  end
end
