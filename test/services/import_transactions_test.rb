require_relative '../test_helper'

module Services
  class ImportTransactionsTest < ActiveSupport::TestCase
    context 'import transactions sevice tests' do
      should 'import the transactions in the file' do
        import = Import.create! filepath: 'test/data/test_transactions1.csv'
        Services::ImportTransactions.call import
        assert_equal 15, Transaction.count
      end

      should 'clean imported field valuess' do
        import = Import.create! filepath: 'test/data/test_transactions_white_space.csv'
        Services::ImportTransactions.call import
        assert_equal 1, Transaction.count

        transaction = Transaction.first
        assert_equal 'XXXX-1234',                             transaction.account_number
        assert_equal Date.strptime('01/28/2016', '%m/%d/%Y'), transaction.posted_at.to_date
        assert_equal Date.strptime('01/26/2016', '%m/%d/%Y'), transaction.transaction_at.to_date
        assert_equal 'health_medical',                        transaction.category
        assert_equal 'Health & Medical',                      transaction.category_raw
        assert_equal 'DENTIST OFFICE',                        transaction.merchant_name
        assert_equal 'SMALLVILLE',                            transaction.merchant_city
        assert_equal 'KA',                                    transaction.merchant_state
        assert_equal 'Dentists  Orthodontists',               transaction.description
        assert_equal 'Purchase',                              transaction.transaction_type
        assert_equal 120.0,                                   transaction.amount
        assert_equal '12321356027987110000989',               transaction.reference
      end

      should 'not import overlapping transactions' do
        import = Import.create! filepath: 'test/data/test_transactions1.csv'
        Services::ImportTransactions.call import
        import = Import.create! filepath: 'test/data/test_transactions2.csv'
        Services::ImportTransactions.call import
        assert_equal 16, Transaction.count
      end

      should 'raise an error if there are formatting problems in the csv file' do
        import = Import.create! filepath: 'test/data/test_format_problem.csv'
        Services::ImportTransactions.call import
      end

      should 'raise an error if no file is provided' do
        exception = assert_raises(Exception) { Services::ImportTransactions.call nil }
        assert_equal 'No import model given', exception.message
      end

      should 'raise an error if the file does not exist' do
        import = Import.create! filepath: 'test/data/there_is_no_file.csv'
        exception = assert_raises(Exception) { Services::ImportTransactions.call import }
        assert_equal "File #{import.filepath} does not exist", exception.message
      end

      should 'raise an error when importing file that is not a csv file buh' do
        import = Import.create! filepath: 'test/data/test_not_csv.txt'

        exception = assert_raises(Exception) { Services::ImportTransactions.call import }
        assert_equal "File #{import.filepath} is not a csv file", exception.message
      end
    end
  end
end
