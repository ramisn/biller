class Account < ActiveRecord::Base
  has_many :invoices 
  has_many :account_contacts
  belongs_to :organization
  
  validates :display_name,  :presence => true
  validates :organization, :presence => true
  validates :phone ,:numericality => true,:length => { :minimum => 9 }
  after_create :invite_user

 
  def self.search(params)
    where("display_name LIKE ? AND organization_id = ?", "#{params[:q]}%", params[:organization_id]).page(params[:page]).order("#{params[:sort]} #{params[:sort_dir]}")
  end

  #instance methods
  def invite_user
    
  	UserMailer.invite_user(self).deliver
  end

end
