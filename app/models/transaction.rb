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

  # Public: Return the amount of expenditures that have occurred since the
  # first of the month
  #
  # Returns: big decimal
  def self.monthly_sum_to_date
    monthly_to_date.sum(:amount)
  end
end
