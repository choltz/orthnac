class DashboardController < ApplicationController
  def index
    # @monthly_sum_to_date = Transaction.select('sum(amount) as amount')
    #                                   .where("transaction_type <> 'Payment' and transaction_at between ? and ?", Date.today.beginning_of_month, Date.today)
    #                                   .first.try(:amount) || 0.0
  end
end
