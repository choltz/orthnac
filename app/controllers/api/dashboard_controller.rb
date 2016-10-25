module Api
  class DashboardController < ApplicationController
    def graph
      data = Functions::Transactions.cumulative_spending_by_month.call(Date.today)
      render json: data
    end
  end
end
