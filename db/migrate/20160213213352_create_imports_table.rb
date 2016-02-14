class CreateImportsTable < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.text :filename
      t.text :filepath
      t.timestamps
    end
  end
end
