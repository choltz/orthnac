class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.search(params[:search])
                               .order('transaction_at desc')
                               .page(params[:page])
                               .per(20)
  end
end
