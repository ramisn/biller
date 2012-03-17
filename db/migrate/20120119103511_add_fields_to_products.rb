class AddFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :key, :string, :null => false, :default => ""
    add_column :products, :description , :text, :null => true, :limit => 255
  end
end
