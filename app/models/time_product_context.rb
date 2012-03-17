##
# This context would only be used in invoice calculation during
# a certain time of day.
class TimeProductContext < ProductContext
  belongs_to :product
  
  # The times the product context is valid for
  attr_accessor :start_time, :end_time
  
  def executable?
    # Is the given time within the start and end time?
  end
end
