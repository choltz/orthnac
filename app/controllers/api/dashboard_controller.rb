module Api
  class DashboardController < ApplicationController
    def graph
      data = Functions::Transactions.cumulative_spending_by_month(Date.today, params[:category]).call
      render json: data
    end
  end
end
