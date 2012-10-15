class Invoice < ActiveRecord::Base
  has_many :line_items
  accepts_nested_attributes_for :line_items 
#  belongs_to :status, :class_name => "InvoiceStatus"
  has_many :status_logs, :class_name => "InvoiceStatusLog"
   accepts_nested_attributes_for :status_logs 
  belongs_to :account
 # belongs_to :account_contact
  belongs_to :organization

  validates :account_id ,:presence=>true
  validates :statuses  ,:presence=>true
  def self.search(params)
    where("statuses LIKE ? AND organization_id = ?", params[:q], params[:organization_id]).page(params[:page]).order("#{params[:sort]} #{params[:sort_dir]}")
  end


    paginates_per 10

end
