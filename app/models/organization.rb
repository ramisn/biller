class Organization < ActiveRecord::Base
  has_many :users
  has_many :invoices
  has_many :products
  has_many :accounts
  
  validates :name,  :presence => true
end
