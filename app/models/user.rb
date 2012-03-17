class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :display_name, 
      :organization, :organization_attributes
  
  belongs_to :organization
  accepts_nested_attributes_for :organization
  
  validates_presence_of :email, :display_name
  validates :email, :uniqueness => {:case_sensitive => false }
end
