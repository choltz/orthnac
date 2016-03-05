class AddTransactionsCategoriesRaw < ActiveRecord::Migration
  def change
    add_column :transactions, :category_raw, :text
  end
end
