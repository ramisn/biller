class CreateRulesTables < ActiveRecord::Migration
  def change
    
    create_table :products do |t|
      t.references :organization
      t.string :name
      t.float :unit_price
      t.timestamps
    end

    # Polymorphic
    create_table :product_contexts do |t|
      t.references :product
      t.string :type # holiday, regular, time, etc. This is a polymorphic column
      t.integer :parent_id # tree structure so that contexts can be nested
      t.integer :lft
      t.integer :rgt
      t.float :unit_price
      t.text :parameters # JSON encoded additional parameters for this context
      t.timestamps
    end

    create_table :account_product_contexts do |t|
      t.references :account
      t.references :product_context, :null => true
      t.references :product, :null => false
      t.float :unit_price, :null => false # A row should only be inserted if we are over-riding the default price
      t.timestamps
    end
  end
end
