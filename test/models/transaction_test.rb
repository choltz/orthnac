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

    create_transaction 'Purchase',       10.00,   date + 1, '1a', 'Automotive',       'amazon'
    create_transaction 'Purchase',       20.00,   date + 2, '2b', 'Home & Household', 'local grocer'
    create_transaction 'Payment',        -10.00,  date + 3, '3c', 'Medical',          'dentist, inc.'
    create_transaction 'Credit Voucher', -10.00,  date + 4, '4d', 'Entertainment',    'the movie place'
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
      assert_equal '2016-09-01', sums.first.month
      assert_equal 20,           sums.first.sum
      assert_equal 20,           sums.first.home_household_sum
      assert_equal 10,           sums.first.automotive_sum
      assert_equal -10,          sums.first.entertainment_sum
    end

    should 'return sums grouped by month for specific categories' do
      sums = Transaction.sums_by_month('Entertainment', 'Automotive')

      assert_equal 5, sums.first.attributes.length
      assert_equal 1, sums.length
      assert_equal '2016-09-01', sums.first.month
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

  context 'search' do
    should 'search for transactions by category' do
      assert_equal 1, Transaction.search('Medical').count
    end

    should 'search for transactions by case insensitive category' do
      assert_equal 1, Transaction.search('medical').count
    end

    should 'partial match search for transactions by category' do
      assert_equal 1, Transaction.search('medi').count
    end

    should 'search for transactions by merchant' do
      assert_equal 1, Transaction.search('Amazon').count
    end

    should 'search for transactions by case insensitive merchant' do
      assert_equal 1, Transaction.search('amazon').count
    end

    should 'partial match search for transactions by merchant' do
      assert_equal 1, Transaction.search('amaz').count
    end

    should 'search for transactions by amount' do
      assert_equal 1, Transaction.search('20.00').count
    end
  end

  context 'cumulative_spending_by_month' do
    setup do
      Transaction.destroy_all

      date = Date.today
      create_transaction 'Purchase', 10.00, date - 6, '3a',  'Automotive',       'amazon'
      create_transaction 'Purchase', 20.00, date - 6, '4b',  'Home & Household', 'local grocer'
      create_transaction 'Purchase', 10.00, date - 10, '5a', 'Automotive',       'amazon'
      create_transaction 'Purchase', 20.00, date - 10, '6b', 'Home & Household', 'local grocer'
      create_transaction 'Purchase', 10.00, date - 12, '7a',  'Automotive',       'amazon'
      create_transaction 'Purchase', 20.00, date - 14, '7b',  'Home & Household', 'local grocer'
      create_transaction 'Purchase', 10.00, date - 15, '8a', 'Automotive',       'amazon'
      create_transaction 'Purchase', 20.00, date - 16, '8b', 'Home & Household', 'local grocer'
    end

    should 'show accumulated spending' do
      expected = [['0825', 0, 0], ['0826', 0, 0], ['0827', 0, 0], ['0828', 0, 0], ['0829', 0, 0], ['0830', 0, 0], ['0831', 0, 0], ['0901', 0, 0], ['0902', 0, 0], ['0903', 0, 0], ['0904', 0, 0], ['0905', 0, 0], ['0906', 0, 0], ['0907', 0, 0], ['0908', 0, 0], ['0909', 20, 20], ['0910', 30, 10], ['0911', 50, 20], ['0912', 50, 0], ['0913', 60, 10], ['0914', 60, 0], ['0915', 90, 30], ['0916', 90, 0], ['0917', 90, 0], ['0918', 90, 0], ['0919', 120, 30], ['0920', 120, 0], ['0921', 120, 0], ['0922', 120, 0], ['0923', 120, 0], ['0924', 120, 0], ['0925', 120, 0], ['0926', 120, 0], ['0927', 120, 0], ['0928', 120, 0], ['0929', 120, 0], ['0930', 120, 0], ['1001', 120, 0], ['1002', 120, 0], ['1003', 120, 0], ['1004', 120, 0], ['1005', 120, 0], ['1006', 120, 0], ['1007', 120, 0], ['1008', 120, 0], ['1009', 120, 0], ['1010', 120, 0], ['1011', 120, 0], ['1012', 120, 0], ['1013', 120, 0], ['1014', 120, 0], ['1015', 120, 0], ['1016', 120, 0], ['1017', 120, 0], ['1018', 120, 0], ['1019', 120, 0], ['1020', 120, 0], ['1021', 120, 0], ['1022', 120, 0], ['1023', 120, 0], ['1024', 120, 0], ['1025', 120, 0]]
      assert_equal expected, Transaction.cumulative_spending_by_month(Time.now - 1.month, Time.now + 1.month)
    end
  end

  private

  # Internal: create a transaction with a default account name
  def create_transaction(type, amount, date, reference, category, merchant)
    Transaction.create! account_number:   'test account',
                        amount:           amount,
                        category:         category,
                        import_id:        1,
                        merchant_name:    merchant,
                        reference:        reference,
                        transaction_type: type,
                        transaction_at:   date

  end
end
