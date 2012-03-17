class AddContextTypeColumnToProductContext < ActiveRecord::Migration
  def change
    add_column :product_contexts, :context_type ,:string
  end
end
