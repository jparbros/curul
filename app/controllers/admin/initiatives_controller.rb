class Admin::InitiativesController < Admin::BaseController
  def index
    @initiatives = Initiative.page(params[:page])
  end
  
  def show
    @initiative = Initiative.find(params[:id])
  end
  
  def new
    @initiative = Initiative.new
    @initiative.official_votes_objects
  end
  
  def create
    @initiative = Initiative.new(params[:initiative])
    if @initiative.save
      redirect_to admin_initiatives_url, :notice => "Iniciativa creada exitosamente"
    else
      render :new
    end
  end
  
  def update
    @initiative = Initiative.find(params[:id])
    if @initiative.update_attributes(params[:initiative])
      redirect_to admin_initiatives_url, :notice => "Iniciativa editada exitosamente"
    else
      render :edit
    end
  end
  
  def edit
    @initiative = Initiative.find(params[:id])
    @initiative.official_votes_objects true
  end
  
  def destroy
    @initiative = Initiative.find(params[:id])
    @initiative.destroy
    redirect_to admin_initiatives_url
  end
end
