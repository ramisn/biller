class ProductContext < ActiveRecord::Base
  acts_as_nested_set
  belongs_to :product
  
  ##
  # Can this product context be executed under the current conditions?
  #
  # @return <Boolean> True if the product context can be executed.
  def executable?
    raise NotImplementedError.new("Child class should provide implementation")
  end
end
