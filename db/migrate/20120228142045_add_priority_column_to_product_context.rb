class AddPriorityColumnToProductContext < ActiveRecord::Migration
  def change
     add_column :product_contexts, :context_priority  ,:integer
  end
end
