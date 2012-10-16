class Admin::InitiativesController < Admin::BaseController
  load_and_authorize_resource
  
  def index
    @initiatives = if params[:search]
            Initiative.filters(params[:search]).results
          else
            Initiative.page(params[:page])
          end
  end

  def show
    @initiative = Initiative.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @initiative.attributes }
    end
  end

  def new
    @initiative = Initiative.new
    @initiative.official_votes_objects
    @initiative.resources.build
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
    @initiative.resources.build
  end

  def destroy
    @initiative = Initiative.find(params[:id])
    @initiative.destroy
    redirect_to admin_initiatives_url
  end
end
