require 'date'

module Cavc
  module Operation
    module Input
      def self.input_contest
        opt = {}

        puts "作成するコンテストの情報を入力してください"

        print "タイトル []: "
        tmp = STDIN.gets.chomp
        if tmp.length == 0
          puts "空文字は許可されていません"
          exit 1
        end
        opt['title'] = tmp
        
        today = Date.today.strftime("%Y/%m/%d")

        print "開始日(yyyy/mm/dd) [#{today}]: "
        tmp = STDIN.gets.chomp
        if tmp == ""
          opt['start_day'] = today
        else
          opt['start_day'] = tmp
        end

        print "終了日(yyyy/mm/dd) [#{today}]: "
        tmp = STDIN.gets.chomp
        if tmp == ""
          opt['end_day'] = today
        else
          opt['end_day'] = tmp
        end

        check_day(opt['start_day'], opt['end_day'])

        print "開始時間(hh:mm) []: "
        st = STDIN.gets.chomp
        # ガバガバすぎるしTimeとかでいい感じの探したほうがいい
        if st == "" || st !~ /^([0-1][0-9]|[2][0-3]):[0-5]?[05]$/
          puts "入力値が不正です"
          puts "分の入力は5の倍数のみ許可されます"
          exit 1
        end

        print "終了時間(hh:mm) []: "
        et = STDIN.gets.chomp
        # ガバガバすぎるしTimeとかでいい感じの探したほうがいい
        if et == "" || et !~ /^([0-1][0-9]|[2][0-3]):[0-5]?[05]$/
          puts "入力値が不正です"
          puts "分の入力は5の倍数のみ許可されます"
          exit 1
        end

        check_time(opt['start_day'], opt['end_day'], st, et)

        opt['start_hour'], opt['start_minute'] = st.split(':').map(&:to_i)
        opt['end_hour'], opt['end_minute'] = et.split(':').map(&:to_i)

        print "ペナルティ(minute) [5]: "
        tmp = STDIN.gets.chomp
        if tmp == ""
          opt['penalty'] = "5"
        else
          opt['penalty'] = tmp
        end

        print "非公開設定([t|true] or [f|false]) [true]: "
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

      def self.input_problem
        puts "追加したい問題をスペース区切りで入力してください"
        puts "例えば、[ABC017のA-D問題]と[ARC010のA-B問題]を追加したい場合は[abc017abcd arc010ab]と入力します"
        print "追加する問題 []: "
        input_problems = STDIN.gets.chomp.split
        reshape_prob(input_problems)
      end

      private

      def self.check_day(sd, ed)
        if sd > ed
          puts "終了日が開始日よりも前です"
          exit 1
        end
      end

      def self.check_time(sd, ed, st, et)
        if sd == ed
          if st >= et
            puts "終了日時が開始日時よりも前か、同じです"
            exit 1
          end
        end
      end

      def self.reshape_prob(probs)
        # abcとarcのみ対応
        problems = {
          'abc' => {},
          'arc' => {}
        }
        abc = probs.select { |t| t =~ /^abc/ }
        arc = probs.select { |t| t =~ /^arc/ }

        # abc
        abc.each do |x|
          contest_number = x[3..5]
          contest_problems = x[6..-1]
          problems['abc'].store(contest_number, contest_problems)
        end

        # arc
        arc.each do |x|
          contest_number = x[3..5]
          contest_problems = x[6..-1]
          problems['arc'].store(contest_number, contest_problems)
        end

        prob_list = []
        problems.each do |pk, pv|
          if pk == "abc"
            pv.each do |k, v|
              if k.to_i > 19
                v.split('').each do |pn|
                  prob_list << "http://abc#{k}.contest.atcoder.jp/tasks/abc#{k}_#{pn}"
                end
              else
                v.split('').each do |pn|
                  prob_list << "http://abc#{k}.contest.atcoder.jp/tasks/abc#{k}_#{pn.ord-96}"
                end
              end
            end
          elsif pk == "arc"
            pv.each do |k, v|
              if k.to_i > 34
                v.split('').each do |pn|
                  prob_list << "http://arc#{k}.contest.atcoder.jp/tasks/abc#{k}_#{pn}"
                end
              else
                v.split('').each do |pn|
                  prob_list << "http://arc#{k}.contest.atcoder.jp/tasks/abc#{k}_#{pn.ord-96}"
                end
              end
            end
          end
        end

        prob_list
      end
    end
  end
end
