# Public: Account model.
class Account < ActiveRecord::Base
  def self.stub_account
    { name: 'All Accounts', code: 'all' }
  end
end
