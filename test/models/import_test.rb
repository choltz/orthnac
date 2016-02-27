require_relative '../test_helper'

# Import model tests
class ImportTest < ActiveSupport::TestCase
  should have_many :transactions
end
