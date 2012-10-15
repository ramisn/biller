class AccountsController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb "Accounts", :accounts_path
  
  def index
    params[:sort] ||= "display_name"
    params[:sort_dir] ||= "asc"
    filters = params.dup
    filters[:organization_id] = current_user.organization_id
    
    @accounts = Account.search(filters)
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @accounts }
    end
  end 
  
  def show
    add_breadcrumb @account.display_name, account_path(@account)
    @account=Account.find(params[:id])
  end
  
  def new
    add_breadcrumb "New Account", new_account_path
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @account }
    end
  end
  
  def create
  	@success = false
    @account.organization = current_user.organization
    @org=current_user.organization
    @account_current_user = @org.accounts
    respond_to do |format|
      if @account.save
      	@success = true
        
      	if params[:call_from]
		    	 format.html {
						    flash[:success] = "Account was added successfully"
						    redirect_to new_invoice_path
						  }
						format.js	
      	else         
		      format.html {
				      flash[:success] = "Account was added successfully"
				      redirect_to account_path(@account)
				    }
				    format.json  { render :json => @account,
				                  :status => :created, :location => @account }
		    end
      else
      	if params[:call_from]
      			format.html { redirect_to new_invoice_path
						  }
					@errors = @account.errors
					format.js
				else
        format.html  { render :action => :new }
        format.json  { render :json => @account.errors,
                      :status => :unprocessable_entity } 
      	end
      end
    end
  end
  
  def edit
    add_breadcrumb @account.display_name, account_path(@account)
    add_breadcrumb "Edit", edit_account_path(@account)
  end
  
  def update
    if @account.update_attributes(params[:account])
      respond_to do |format|
        format.html {
          flash[:success] = "Account updated successfully"
          redirect_to account_path(@account)
        }
        format.json { render :json => @account }
      end
    else
      respond_to do |format|
        format.html { render :action => :edit }
        format.json { render :json => @account.errors, :status => :unprocessible_entity }
      end
    end
  end
end
