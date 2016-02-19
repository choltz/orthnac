class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.order('transaction_at desc')
  end
end
