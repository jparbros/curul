Congresspedia::Application.routes.draw do
  namespace :admin do
    resources :initiatives do
      resource :main, :controller => :main, :only => [:create]
    end
    resources :topics
    resources :political_parties
    resources :representatives
    
    root :to => "dashboard#show"
  end
  resources :iniciativas, :only => [:index, :show] do
    get 'page/:page', :action => :index, :on => :collection
    resource :vote_up, :controller => :vote_up, :only => [:create]
    resource :vote_down, :controller => :vote_down, :only => [:create]
    resources :comments, :only => [:create]
  end
  resources :congresistas, :only => [:index, :show] do
    resources :comentarios, :only => [:create]
  end
  resources :regiones, :only => [:show]
  resource :acerca_de, :only => [:show], :controller => :acerca_de
  resource :entiende_tu_congreso, :only => [:show], :controller => :entiende
  resource :proceso_legislativo, :only => [:show], :controller => :proceso_legislativo
  resource :como_funciona_congreso, :only => [:show], :controller => :funciona_congreso
  resource :abc_legislativo, :only => [:show], :controller => :abc_legislativo
  resource :contacto, :only => [:new, :create], :controller => :contacto
  resource :comenta, :only => [:show, :create], :controller => :comenta
  
  match "busqueda/iniciativas", :to => "search_initiatives#create", :via => :post, :as => "search_initiatives"
  match "busqueda/iniciativas", :to => "search_initiatives#create", :via => :get, :as => "search_initiatives"
  
  root :to => "home#show"
end
