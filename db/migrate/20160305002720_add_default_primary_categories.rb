class AddDefaultPrimaryCategories < ActiveRecord::Migration
  def change
    setting = Setting.first
    setting.update_attribute :primary_categories, 'groceries, dining_out, health_medical'
  end
end
