require_relative '../test_helper'

# Transaction model tests
class TransactionTest < ActiveSupport::TestCase
  should validate_presence_of :reference
  should validate_presence_of :account_number
  should validate_presence_of :transaction_at
  should validate_presence_of :transaction_type
  should validate_presence_of :amount

  should validate_uniqueness_of :reference

  context 'montly transactions' do
    setup do
      date = Date.today.beginning_of_month

      create_transaction 'Purchase',       10.00,   date + 1, 1
      create_transaction 'Purchase',       20.00,   date + 2, 2
      create_transaction 'Payment',        -10.00,  date + 3, 3
      create_transaction 'Credit Voucher', -10.00,  date + 4, 4
    end

    should 'return all transactions since the beginning of the month' do
      references = Transaction.monthly_to_date.pluck(:reference)
      assert_equal true, (references - %w( 1 2 4 )).empty?
    end

    should 'sum the amount spent since the beginning of the month' do
      assert_equal 20, Transaction.monthly_sum_to_date.to_i
    end
  end

  private

  # Internal: create a transaction with a default account name
  def create_transaction(type, amount, date, reference)
    Transaction.create! transaction_type: type,
                        amount:           amount,
                        transaction_at:   date,
                        reference:        reference,
                        account_number:   'test account'
  end
end
