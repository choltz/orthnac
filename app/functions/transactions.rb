module Functions
  class Transactions < FunctionGroup
    MAX_SPENDING = 3500

    # Return cumulative spending over a date range
    compose :cumulative_spending_by_month, ->(start_date, end_date) {
      empty_cumulative_set(start_date, end_date) >>
      get_daily_totals(start_date, end_date)     >>
      get_cumulative_totals
    }

    class << self
      # create empty data set: { '0901' => [0, 0, 3500], '0902' => [0, 0, 3500], '0903' => [0, 0, 3500], ...}
      def empty_cumulative_set(start_date, end_date)
        Function.new do
          (start_date.to_date..end_date.to_date).reduce({}) do |hash, date|
            hash.merge(DateTools.month_and_day(date) => [0, 0, MAX_SPENDING])
          end
        end
      end

      # populate data set with transaction amounts per day: {'0901' => [0,100], '0902' => [0,30], '0903' => [0,10], ...}
      def get_daily_totals(start_date, end_date)
        Function.new do |data|
          Transaction.between(start_date, end_date).where("transaction_type <> 'Payment'").each do |transaction|
            data[DateTools.month_and_day(transaction.transaction_at)][1] += transaction.amount.to_i
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
                                                   item[3]] }
        end
      end
    end
  end
end
