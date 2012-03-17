class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :users do |t|
      t.references :organization
      t.string :display_name
      t.timestamps
    end
    
    create_table :accounts do |t|
      t.references :organization
      t.string :display_name
      t.timestamps
    end
    
    create_table :invoice_statuses do |t|
      t.string :name
      t.integer :priority
    end
    
    create_table :invoices do |t|
      t.references :organization
      t.references :account
      t.references :invoice_status
      t.timestamps
    end
    
    create_table :invoice_status_logs do |t|
      t.references :invoice
      t.references :invoice_status
      t.integer :created_by
      t.text :note
      t.timestamps
    end
    
    create_table :invoice_line_items do |t|
      t.references :invoice
      t.string :name
      t.float :quantity
      t.float :unit_price
      t.timestamps
    end
  end
end
