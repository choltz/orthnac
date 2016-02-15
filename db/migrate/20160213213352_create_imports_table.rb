class CreateImportsTable < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.text :filename
      t.text :filepath
      t.text :message
      t.timestamps
    end
  end
end
