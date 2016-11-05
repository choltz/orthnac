module Api
  class DashboardController < ApplicationController
    def graph
      date = params[:date].nil? ? Date.today : Date.parse(params[:date] +'-01' )
      data = Functions::Transactions.cumulative_spending_by_month(date, params[:category]).call
      render json: data
    end
  end
end
