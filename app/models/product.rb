class Product < ActiveRecord::Base
 
  belongs_to :organization
  has_many :product_contexts
  
  validates :unit_price,  :presence => true
  validates :name, :presence => true
  validates :key,  :presence => true
  validates :organization, :presence => true
  validates_uniqueness_of :key
  
  def self.search(params)
    where("name LIKE ? AND organization_id = ?", "#{params[:q]}%", params[:organization_id]).order("#{params[:sort]} #{params[:sort_dir]}").page(params[:page])
  end
end
