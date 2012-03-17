class AddStatusToInvoices < ActiveRecord::Migration
  def change
  	 add_column :invoices, :statuses, :string
  end
end
