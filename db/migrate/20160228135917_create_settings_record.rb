class CreateSettingsRecord < ActiveRecord::Migration
  def change
    # The settings table should not be blank
    Setting.create!
  end
end
