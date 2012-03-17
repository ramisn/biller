class InvoiceStatus < ActiveRecord::Base
  
  has_one :invoice_status 
end
