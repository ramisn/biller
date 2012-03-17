class ApplicationController < ActionController::Base
  protect_from_forgery
  add_breadcrumb "Dashboard", :root_path
end
