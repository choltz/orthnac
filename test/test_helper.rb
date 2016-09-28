ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Make sure we always have a setting record
Setting.create! if Setting.count == 0

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

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
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
