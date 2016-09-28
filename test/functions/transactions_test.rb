require_relative '../test_helper'

module Functions
  class TranactionsTest < ActiveSupport::TestCase

    context 'cumulative_spending_by_month' do
      setup do
        @date = Date.parse('2016-08-25')
        create_transaction 'Purchase', 10.00, @date - 6, '3a',  'Automotive',       'amazon'
        create_transaction 'Purchase', 20.00, @date - 6, '4b',  'Home & Household', 'local grocer'
        create_transaction 'Purchase', 10.00, @date - 10, '5a', 'Automotive',       'amazon'
        create_transaction 'Purchase', 20.00, @date - 10, '6b', 'Home & Household', 'local grocer'
        create_transaction 'Purchase', 10.00, @date - 12, '7a',  'Automotive',       'amazon'
        create_transaction 'Purchase', 20.00, @date - 14, '7b',  'Home & Household', 'local grocer'
        create_transaction 'Purchase', 10.00, @date - 15, '8a', 'Automotive',       'amazon'
        create_transaction 'Purchase', 20.00, @date - 16, '8b', 'Home & Household', 'local grocer'
      end

      should 'show accumulated spending' do
        expected = [["0825", 0, 0, 3500], ["0826", 0, 0, 3500], ["0827", 0, 0, 3500], ["0828", 0, 0, 3500], ["0829", 0, 0, 3500], ["0830", 0, 0, 3500], ["0831", 0, 0, 3500], ["0901", 0, 0, 3500], ["0902", 0, 0, 3500], ["0903", 0, 0, 3500], ["0904", 0, 0, 3500], ["0905", 0, 0, 3500], ["0906", 0, 0, 3500], ["0907", 0, 0, 3500], ["0908", 0, 0, 3500], ["0909", 0, 0, 3500], ["0910", 0, 0, 3500], ["0911", 0, 0, 3500], ["0912", 0, 0, 3500], ["0913", 0, 0, 3500], ["0914", 0, 0, 3500], ["0915", 0, 0, 3500], ["0916", 0, 0, 3500], ["0917", 0, 0, 3500], ["0918", 0, 0, 3500], ["0919", 0, 0, 3500], ["0920", 0, 0, 3500], ["0921", 0, 0, 3500], ["0922", 0, 0, 3500], ["0923", 0, 0, 3500], ["0924", 0, 0, 3500], ["0925", 0, 0, 3500]]
        assert_equal expected, Functions::Transactions.cumulative_spending_by_month(@date, @date + 1.month).call
      end
    end

  end
end
