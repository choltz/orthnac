require_relative '../test_helper'

# Transaction model tests
class TransactionTest < ActiveSupport::TestCase
  should validate_presence_of :reference
  should validate_presence_of :account_number
  should validate_presence_of :transaction_at
  should validate_presence_of :transaction_type
  should validate_presence_of :amount
  should validate_presence_of :import_id
  should validate_uniqueness_of :reference
  should belong_to            :import

  setup do
    date = Date.today.beginning_of_month

    create_transaction 'Purchase',       10.00,   date + 1, '1a', 'Automotive'
    create_transaction 'Purchase',       20.00,   date + 2, '2b', 'Home & Household'
    create_transaction 'Payment',        -10.00,  date + 3, '3c', 'Medical'
    create_transaction 'Credit Voucher', -10.00,  date + 4, '4d', 'Entertainment'
  end

  context 'montly transactions' do
    should 'return all transactions since the beginning of the month' do
      references = Transaction.monthly_to_date.pluck(:reference)
      assert_equal true, (references - %w( 1a 2b 4d )).empty?
    end

    should 'sum the amount spent since the beginning of the month' do
      assert_equal 20, Transaction.monthly_sum_to_date.to_i
    end

    should 'return sums grouped by month and category' do
      sums = Transaction.sums_by_month

      assert_equal 1, sums.length
      assert_equal '2016-03-01', sums.first.month
      assert_equal 20,           sums.first.sum
      assert_equal 20,           sums.first.home_household_sum
      assert_equal 10,           sums.first.automotive_sum
      assert_equal -10,          sums.first.entertainment_sum
    end

    should 'return sums grouped by month for specific categories' do
      sums = Transaction.sums_by_month('Entertainment', 'Automotive')

      assert_equal 5, sums.first.attributes.length
      assert_equal 1, sums.length
      assert_equal '2016-03-01', sums.first.month
      assert_equal 20,           sums.first.sum
      assert_equal -10,          sums.first.entertainment_sum
      assert_equal 10,           sums.first.automotive_sum
    end
  end

  context 'categories' do
    should 'return a list of all categories with slugged codes' do
      categories = [['Home & Household', 'home_household'],
                    ['Automotive',       'automotive'],
                    ['Entertainment',    'entertainment'],
                    ['Medical',          'medical']]

      assert_equal categories, Transaction.categories
    end

    should 'return a list of all category names' do
      assert_equal ['Home & Household', 'Automotive', 'Entertainment', 'Medical'], Transaction.category_names
    end

    should 'return a list of all category codes' do
      assert_equal %w(home_household automotive entertainment medical), Transaction.category_codes
    end
  end

  private

  # Internal: create a transaction with a default account name
  def create_transaction(type, amount, date, reference, category)
    Transaction.create! account_number:   'test account',
                        amount:           amount,
                        category:         category,
                        import_id:        1,
                        reference:        reference,
                        transaction_type: type,
                        transaction_at:   date

  end
end
