class Admin::LegislaturesController < Admin::BaseController
  skip_authorization_check
  
  def index
    @legislatures = Legislature.page(params[:page])
  end
  
  def new
    @legislature = Legislature.new
  end
  
  def create
    @legislature = Legislature.new params[:legislature]
    if @legislature.save
      redirect_to admin_representatives_url, notice: 'Legislatura creada exitosamente.'
    else
      render :new, error: 'Ocurrio un error al guardar la legislatura.'
    end
  end
  
  def edit
    @legislature = Legislature.find params[:id]
  end
  
  def update
    @legislature = Legislature.new params[:id]
    if @legislature.update_attributes params[:legislature]
      redirect_to admin_representatives_url, notice: 'Legislatura editada exitosamente.'
    else
      render :new, error: 'Ocurrio un error al editar la legislatura.'
    end
  end
  
  def destroy
    @legislature = Legislature.new params[:id]    
    @legislature.destroy
    redirect_to admin_representative_url
  end
end
