class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @invoices=[]
    accounts = current_user.try(:organization).accounts
    accounts.each do |acc|
      @invoices << acc.invoices
    end
  end
end