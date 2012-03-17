class InvoiceStatusLog < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :status, :class_name => "InvoiceStatus"
  belongs_to :created_by, :class_name => "User"
end
