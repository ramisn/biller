class ChangeColumnNameOfProductContexts < ActiveRecord::Migration
  def up
    change_table :product_contexts do |t|
      t.rename :type, :product_type
    end
  end

  def down
    change_table :product_contexts do |t|
      t.rename :product_type, :type
    end
  end
end
