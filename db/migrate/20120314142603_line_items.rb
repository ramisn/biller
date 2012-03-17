class LineItems < ActiveRecord::Migration
  def up
  create_table :line_items do |t|
      t.integer :invoice_id
      t.string :name
      t.float :quantity
      t.float :unit_price
      t.timestamps
  end
  end

  def down
  end
end
