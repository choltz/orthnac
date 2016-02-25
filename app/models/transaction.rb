# Public: Transaction model. Contains payments, expenditures, and credits
class Transaction < ActiveRecord::Base
  # Return all transactions between the specified start and end date
  scope :between, ->(start_date, end_date) {
    where('transaction_at between ? and ?', start_date, end_date)
  }

  # Return all transactions, except for payments, since he beginning of the
  # month
  scope :monthly_to_date, -> {
    where("transaction_type <> 'Payment'")
      .between(Date.today.beginning_of_month, Date.today)
  }

  # Class Methods
  class << self
    # Public: Return the amount of expenditures that have occurred since the
    # first of the month
    #
    # Returns: big decimal
    def monthly_sum_to_date
      monthly_to_date.sum(:amount)
    end

    def amount_sums_by_month
      # select strftime('%Y-%m', transaction_at) as month, sum(amount)
      # from transactions
      # where transaction_at between '2015-02-24' and '2016-02-24'
      # and transaction_type <> 'Payment'
      # group by strftime('%Y-%m', transaction_at)
      # order by month;
    end
  end
end
