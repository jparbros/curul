class Admin::AdminsController < Admin::BaseController
  
  before_filter :access?
  
  def index
    @admins = Admin.all
  end
  
  def new
    @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      redirect_to admin_admins_url, :notice => "Usuario creado exitosamente"
    else
      render :new
    end
  end
  
  def edit
    @admin = Admin.find(params[:id])
  end
  
  def update
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(params[:admin])
      redirect_to admin_admins_url, :notice => "Admin editado exitosamente"
    else
      render :edit
    end
  end
  
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    redirect_to :back
  end
  
  def access?
    #redirect_to admin_root_url unless current_admin.super?
  end
end
