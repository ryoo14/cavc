module Cavc
  module Operation
    module Input
      module Check
        def self.check_day(sd, ed)
          if sd > ed
            puts "終了日が開始日よりも前です。"
            exit 1
          end
        end

        def self.check_time(sd, ed, st, et)
          if sd == ed
            if st >= et
              puts "終了日時が開始日時よりも前か、同じです。"
              exit 1
            end
          end
        end
      end
    end
  end
end
