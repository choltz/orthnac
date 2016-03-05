class CreateSettingsRecord < ActiveRecord::Migration
  def change
    # The settings table should not be blank
    Setting.create! statement_start_day: 20
  end
end
