require_relative '../test_helper'

# Setting model tests
class SettingTest < ActiveSupport::TestCase
  should validate_presence_of :statement_start_day

  context 'Setting model tests' do
  end
end
