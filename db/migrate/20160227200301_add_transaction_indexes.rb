class AddTransactionIndexes < ActiveRecord::Migration
  def change
    add_index :transactions, :account_number
    add_index :transactions, :posted_at
    add_index :transactions, :transaction_at
    add_index :transactions, :category
    add_index :transactions, :transaction_type
    add_index :transactions, :amount
    add_index :transactions, :reference
    add_index :transactions, :import_id
  end
end
