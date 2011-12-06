class Admin::PoliticalPartiesController < Admin::BaseController
  def index
    @political_parties = PoliticalParty.page(params[:page])
  end
  
  def show
    @political_party = PoliticalParty.find(params[:id])
  end
  
  def new
    @political_party = PoliticalParty.new
  end
  
  def create
    @political_party = PoliticalParty.new(params[:political_party])
    if @political_party.save
      redirect_to admin_political_parties_url, :notice => "Etapa creada exitosamente"
    else
      render :new
    end
  end
  
  def update
    @political_party = PoliticalParty.find(params[:id])
    if @political_party.update_attributes(params[:political_party])
      redirect_to admin_political_parties_url, :notice => "Etapa editada exitosamente"
    else
      render :edit
    end
  end
  
  def edit
    @political_party = PoliticalParty.find(params[:id])
  end
  
  def destroy
    @political_party = PoliticalParty.find(params[:id])
    @political_party.destroy
    redirect_to admin_political_parties_url
  end
  
end
