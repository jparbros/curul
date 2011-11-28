class TemasController < ApplicationController
  
  def show
    @topic = Topic.find(params[:id])
    @iniciativas = @topic.initiatives.page(params[:page])
    @temas = Topic.all
    render 'iniciativas/index'
  end
end
