class Setting < ActiveRecord::Base
  validates :statement_start_day, presence: true
end
