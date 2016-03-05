class AddSettingPrimaryCategories < ActiveRecord::Migration
  def change
    add_column :settings, :primary_categories, :text
  end
end
