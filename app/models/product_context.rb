class ProductContext < ActiveRecord::Base
  acts_as_nested_set
  belongs_to :product
  # require 'validations'

  validates :unit_price,:context_priority ,:presence=>true
 #validates_inclusion_of :context_priority, :in => 1...10
  validates_uniqueness_of :context_type , :scope => :product_id ,:unless => Proc.new { |time| time.context_type == "Time"}



    #validates_uniqueness_of :context_type ,:scope => :product_id
    validates_uniqueness_of :context_priority , :scope => :product_id
    # validates_uniqueness_of before_validation_on_create
    #validate :start_time, :timeliness => {:on => Proc.new { validates_datetime :start_time,:allow_blank=>false }, :type => :datetime}
     #
     #def before_validation_on_create :context_type ,:scope => :product_id
         #validates :start_must_be_before_end_time,:uniqueness => true


  #
  # Can this product context be executed under the current conditions?
  #
  # @return <Boolean> True if the product context can be executed.
  def executable?
    raise NotImplementedError.new("Child class should provide implementation")
  end
end
