class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :statement_start_day, null: false, default: 1
    end
  end
end
