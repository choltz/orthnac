class Transaction < ActiveRecord::Base
  scope :monthly_to_date, -> {
    where("transaction_type <> 'Payment'
           and transaction_at between ? and ?", Date.today.beginning_of_month, Date.today)
  }

  # Public: Return the amount of expenditures that have occurred since the
  # first of the month
  #
  # Returns: big decimal
  def self.monthly_sum_to_date
    monthly_to_date.sum(:amount)
  end
end
