class Admin::CommissionsController < Admin::BaseController

  def index
    @commisions =   if params[:q]
        Commission.where("name ilike ?", "%#{params[:q]}%")
      else
        Commission.page(params[:page])
      end
    respond_to do |format|
      format.html
      format.json { render :json => @commisions.map(&:attributes) }
    end
  end

  def new
    @commission = Commission.new
  end

  def create
    @commission = Commission.new(params[:commission])
    if @commission.save
      redirect_to admin_commissions_url, :notice => "Comision creada exitosamente"
    else
      render :new
    end
  end

  def edit
    @commission = Commission.find(params[:id])
  end

  def update
    @commission = Commission.find(params[:id])
    if @commission.update_attributes(params[:commission])
      redirect_to admin_commissions_url, :notice => "Comision editada exitosamente"
    else
      render :edit
    end
  end

  def destroy
    @commission = Commission.find(params[:id])
    @commission.destroy
    redirect_to admin_commissions_url
  end
end
