require_relative '../test_helper'

class TransactionTest < ActiveSupport::TestCase
  context 'montly transactions' do
    setup do
      date = Date.today.beginning_of_month

      Transaction.create! transaction_type: 'Purchase',       amount: 10.00,  transaction_at: date + 1,  reference: '1'
      Transaction.create! transaction_type: 'Purchase',       amount: 20.00,  transaction_at: date + 2,  reference: '2'
      Transaction.create! transaction_type: 'Payment',        amount: -10.00, transaction_at: date + 3,  reference: '3'
      Transaction.create! transaction_type: 'Credit Voucher', amount: -10.00,  transaction_at: date + 4, reference: '4'
    end

    should 'return all transactions since the beginning of the month' do
      references = Transaction.monthly_to_date.pluck(:reference)
      assert (references - ['1','2','4']).empty?
    end

    should 'sum the amount spent since the beginning of the month' do
      assert_equal 20, Transaction.monthly_sum_to_date.to_i
    end
  end
end
