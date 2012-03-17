class AccountContact < ActiveRecord::Base
  belongs_to :account
  has_many :invoices 
  validates :phone ,:numericality => true,:length => { :minimum => 9 }
end
