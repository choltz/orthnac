module Functions
  class Transactions < FunctionGroup
    MAX_SPENDING = 3300

    # Public: Return an array of date/year strings
    compose :date_array, -> {
      Functions::Transactions.min_max_transation_dates >>
      Functions::DateTools.date_object_to_range        >>
      Functions::DateTools.range_to_month_array        >>
      Functions::Arrays.reverse                        >>
      Functions::Util.map{ |date| { display: date.strftime("%B %Y"),
                                    code:    date.strftime("%Y-%m") } }
    }

    class << self
      # public: Get the min and max transaction date
      def min_max_transation_dates
        Function.new do
          Transaction.select('min(transaction_at) as first_date, max(transaction_at) as last_date')
        end
      end

      # Return cumulative spending over a date range
      def cumulative_spending_by_month(date, category)
        Function.new do
          data = (Functions::DateTools.date_to_billing_period >>
                  empty_cumulative_set                        >>
                  current_date_line                           >>
                  add_projected_spending).call(date)

          (get_daily_totals(category) >> get_cumulative_totals).call(data)
        end
      end

      # create empty data set: { '0901' => [0, 0, 3500], '0902' => [0, 0, 3500], '0903' => [0, 0, 3500], ...}
      def empty_cumulative_set
        Function.new do |range|
          range.reduce({}) do |hash, date|
            hash.merge(::DateTools.date_string(date) => [0, 0, MAX_SPENDING, 0, nil])
          end
        end
      end

      def add_projected_spending
        Function.new do |data|
          amount = MAX_SPENDING / data.keys.length

          data.each.with_index.reduce({}) do |hash, (key_value, index)|
            date   = key_value.first
            values = key_value.last
            values.push amount * (index + 1)
            hash.merge date => values
          end
        end
      end

      def current_date_line
        Function.new do |data|
          line = data[Date.today.strftime("%Y/%m/%d")]
          line[line.length - 1] = ''
          data
        end
      end

      # populate data set with transaction amounts per day: {'0901' => [0,100], '0902' => [0,30], '0903' => [0,10], ...}
      def get_daily_totals(category = nil)
        Function.new do |data|
          start_date   = Date.parse data.keys.first
          end_date     = Date.parse data.keys.last
          transactions = Transaction.between(start_date, end_date).where("transaction_type <> 'Payment'")
          transactions = transactions.where(category: category) if category.present? && category != 'all'

          transactions.each do |transaction|
            data[::DateTools.date_string(transaction.transaction_at)][1] += transaction.amount.to_i
          end
          data
        end
      end

      # populate data set with accumulated amounts: [['0901',100,100], ['0902',130,30], ['0903',140,10], ...]
      def get_cumulative_totals
        Function.new do |data|
          data.map(&:flatten)
              .reduce([]){ |array, item| array << [item[0],
                                                   item[2].to_i + (array.length == 0 ? 0 : array.last[1]),
                                                   item[2],
                                                   item[3],
                                                   item[6],
                                                   item[5]] }
        end
      end
    end
  end
end
