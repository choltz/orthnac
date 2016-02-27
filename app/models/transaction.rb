# Public: Transaction model. Contains payments, expenditures, and credits
class Transaction < ActiveRecord::Base
  validates :reference,        presence: true
  validates :account_number,   presence: true
  validates :transaction_at,   presence: true
  validates :transaction_type, presence: true
  validates :amount,           presence: true
  validates :reference,        uniqueness: true

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

    # Public: Calculate the total spending per month, grouped by month
    #
    # Returns: Array of aggregated amounts
    def amount_sums_by_month
      select("strftime('%Y-%m', transaction_at) as month,
              strftime('%m', transaction_at) as month_number,
              sum(amount) as sum")
        .between(1.year.ago.beginning_of_month, Date.today)
        .where("transaction_type <> 'Payment'")
        .group("strftime('%Y-%m', transaction_at)")
        .order('month')
    end
  end
end
