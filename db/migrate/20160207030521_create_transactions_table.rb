class CreateTransactionsTable < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
     t.string   :account_number
     t.datetime :posted_at
     t.datetime :transaction_at
     t.text     :category
     t.text     :merchant_name
     t.text     :merchant_city
     t.text     :merchant_state
     t.text     :description
     t.text     :transaction_type
     t.decimal  :amount, precision: 7, scale: 2
     t.text     :reference
    end
  end
end
