class CreateAccountsTable < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.text     :name, null: false
      t.text     :code, null: false
      t.timestamps
    end
  end
end
