class AddColumnsToProductContext < ActiveRecord::Migration
  def change
    add_column :product_contexts, :start_time, :datetime
    add_column :product_contexts, :end_time, :datetime
  end
end
