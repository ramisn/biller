class AccountContactsController < ApplicationController
  load_and_authorize_resource
  #before_filter :load_and_authorize_account!
  
  def new
    add_breadcrumb "Add New Contact", new_account_contact_path
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @account_contact }
    end        

  end
  
  def create
    @account = Account.find(params[:account_id])
    @account_contact = @account.account_contacts.create(params[:account_contact])
    logger.info(@account_contact)
    respond_to do |format|
      if @account_contact.save         
        format.html {
          flash[:success] = "Account was added successfully."
          redirect_to account_path(@account)
        }
        format.json  { render :json => @account_contact,
                      :status => :created, :location => @account_contact }
      else
        format.html  { render :action => :new }
        format.json  { render :json => @account_contact.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def show
    @account_contact=AccountContact.find(params[:account_id])
   
    add_breadcrumb @account_contact.first_name, account_contact_path(@account_contact)
  end
  def edit
      @account_contact=AccountContact.find(params[:account_id]) 
    add_breadcrumb "Edit #{@account_contact.first_name}", edit_account_contact_path(@account_contact)
  end
  
  def update

    if @account_contact.update_attributes(params[:account_contact])
      respond_to do |format|
        format.html {
          flash[:success] = "Account updated successfully"
          redirect_to account_contact_path(@account_contact)
        }
        format.json { render :json => @account_contact }
      end
    else
      respond_to do |format|
        format.html { render :action => :edit }
        format.json { render :json => @account_contact.errors, :status => :unprocessible_entity }
      end
    end
  end
    
 
  
protected
  
  def load_and_authorize_account!
    @account = Account.find(params[:account_id])
    authorize! :read, @account
    
    add_breadcrumb "Accounts", accounts_path
    add_breadcrumb @account.name, account_path(@account)
  end
end
