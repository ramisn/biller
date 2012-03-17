class AddFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :key, :string, :null => false, :default => ""
    add_column :products, :description , :string 
  end
end
