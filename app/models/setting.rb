# Public: Store app-level values
class Setting < ActiveRecord::Base
  validates :statement_start_day, presence: true

  class << self
    # use this class as a singleton
    def instance
      @instance ||= first
    end

    # Public: Return the next statement billing date
    #
    # Returns: Date
    def next_statement_billing_date
      date = Date.today.beginning_of_month + Setting.statement_start_day - 1
      date = date + 1.month if date < Date.today
      date
    end

    # Public: Get the stored statement start day.
    #
    # Returns: Integer
    def statement_start_day
      instance.statement_start_day
    end

    # Public: Get the start and end dates for the current billing cycle
    def current_statement_dates
      [next_statement_billing_date - 1.month, next_statement_billing_date]
    end
  end
end
