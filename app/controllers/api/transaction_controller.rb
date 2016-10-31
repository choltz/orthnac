module Api
  class TransactionController < ApplicationController
    def categories
      render json: { items: Transaction.categories.map{ |category, _| category } }
    end
  end
end
