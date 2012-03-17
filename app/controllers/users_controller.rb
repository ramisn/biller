class UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
    # TODO: Show all users in organization
  end
  
  def new
    add_breadcrumb "New User", new_user_path

  end
  
  def create
    # TODO: Create new user as part of organization

    respond_to do |format|
      @user.organization = current_user.organization
      @user.password = "password"  
      
      if @user.save         
        format.html { 
          flash[:success] = "Product was created successfully"
          #redirect_to user_path(@user)
          redirect_to root_url
        }
        format.json  { render :json => @user, :status => :success }
      else
        format.html  { render :action => :new }
        format.json  { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    add_breadcrumb "Edit User", edit_user_path(@user)
  end

  def update
    params[:user].delete :organization_id # Cannot change orgs
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "Your Profile was successfully updated." 
        format.html { redirect_to root_url}
        format.json { head :ok }
      else
        format.html { render :action => :edit }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
