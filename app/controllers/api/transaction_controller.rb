module Api
  class TransactionController < ApplicationController
    def categories
      render json: { items: Transaction.categories.map{ |code, display| { code: code, display: display } } }
    end

    def months
      render json: { items: Functions::Transactions.date_array.call }
    end
  end
end
