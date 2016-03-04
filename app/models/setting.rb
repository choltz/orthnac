class Setting < ActiveRecord::Base
  validates :statement_start_day, presence: true

  class << self
    def instance
      @instance ||= first
    end

    def next_statement_billing_date
      date = Date.today.beginning_of_month + Setting.statement_start_day - 1
      date = date + 1.month if date < Date.today
      date
    end

    def statement_start_day
      instance.statement_start_day
    end

    def current_statement_dates
      date = DateTime.new Date.today.year, Date.today.month, instance.statement_start_day
      start_date = date > Date.today ? date - 1.month : date

      [start_date, start_date + 1.month]
    end
  end
end
