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
        expected = [["2016/08/01", 0, 0, 3300, 103, nil], ["2016/08/02", 0, 0, 3300, 206, nil], ["2016/08/03", 0, 0, 3300, 309, nil], ["2016/08/04", 0, 0, 3300, 412, nil], ["2016/08/05", 0, 0, 3300, 515, nil], ["2016/08/06", 0, 0, 3300, 618, nil], ["2016/08/07", 0, 0, 3300, 721, nil], ["2016/08/08", 0, 0, 3300, 824, nil], ["2016/08/09", 0, 0, 3300, 927, nil], ["2016/08/10", 0, 0, 3300, 1030, nil], ["2016/08/11", 0, 0, 3300, 1133, nil], ["2016/08/12", 0, 0, 3300, 1236, nil], ["2016/08/13", 0, 0, 3300, 1339, nil], ["2016/08/14", 0, 0, 3300, 1442, nil], ["2016/08/15", 0, 0, 3300, 1545, nil], ["2016/08/16", 0, 0, 3300, 1648, nil], ["2016/08/17", 0, 0, 3300, 1751, nil], ["2016/08/18", 0, 0, 3300, 1854, nil], ["2016/08/19", 0, 0, 3300, 1957, nil], ["2016/08/20", 0, 0, 3300, 2060, nil], ["2016/08/21", 0, 0, 3300, 2163, nil], ["2016/08/22", 0, 0, 3300, 2266, nil], ["2016/08/23", 0, 0, 3300, 2369, nil], ["2016/08/24", 0, 0, 3300, 2472, nil], ["2016/08/25", 0, 0, 3300, 2575, nil], ["2016/08/26", 0, 0, 3300, 2678, nil], ["2016/08/27", 0, 0, 3300, 2781, nil], ["2016/08/28", 0, 0, 3300, 2884, nil], ["2016/08/29", 0, 0, 3300, 2987, nil], ["2016/08/30", 0, 0, 3300, 3090, nil], ["2016/08/31", 0, 0, 3300, 3193, nil], ["2016/09/01", 0, 0, 3300, 3296, nil]]

        assert_equal expected, Functions::Transactions.cumulative_spending_by_month(@date, @date + 1.month).call
      end
    end

  end
end
