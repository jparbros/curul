class Admin::UsersController < Admin::BaseController
  # load_and_authorize_resource
  skip_authorization_check
  
  def index
    @users = User.page(params[:page])
  end

  def new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to admin_users_url
    else
      render :edit
    end
  end
  
  def show
    
  end
end
