class Holiday < ActiveRecord::Base
  belongs_to :users
  validates_presence_of :holiday_date
end
