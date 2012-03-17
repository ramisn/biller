class AddTotalAmountColumnToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :total_amount ,:string

  end
end
