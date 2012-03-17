require "factory_girl"
require File.join(Rails.root.to_s, "spec", "factories", "accounts.rb")
require File.join(Rails.root.to_s, "spec", "factories", "products.rb")

# Create a Test org and login
org = Organization.create!(:name => "Test Organization")
User.create!(:display_name => "Test User", :organization => org, :password => "password", :email => "test@test.com")

# Create some sample products
60.times do
  Factory.create(:product, :organization => org)
end

35.times do
  Factory.create(:account, :organization => org)
end