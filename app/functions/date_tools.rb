module Functions
  class DateTools < FunctionGroup
    class << self
      # Public: Given a date, return the date range from the beginning to end of
      # the billing period that contains that date.
      def date_to_billing_period
        Function.new do |date|
          start_date = Date.parse "#{date.year}/#{date.month}/#{Setting.statement_start_day}"
          start_date = start_date - 1.month if start_date > Date.today
          start_date..(start_date + 1.month)
        end
      end

      # Public: given an object with a first_date and last_date property, return
      # a range
      def date_object_to_range
        Function.new do |data|
          Date.parse(data.first.first_date)..Date.parse(data.first.last_date)
        end
      end

      # Public: Given a date, return the date rante from the beginning tp end of
      # the month that contains that date.
      def date_to_range
        Function.new do |date|
          date.at_beginning_of_month..date.at_end_of_month
        end
      end

      # Public: convert a date range to an array of month dates
      def range_to_month_array
        Function.new do |range|
          range.select { |date| date.day == 1 }
        end
      end
    end
  end
end
