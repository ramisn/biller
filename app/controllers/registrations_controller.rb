class RegistrationsController < Devise::RegistrationsController
  
  def new
    @user = User.new
    @user.organization = Organization.new
    render "devise/registrations/new"
  end
  
  def edit
    redirect_to user_path(params[:id])
  end
end