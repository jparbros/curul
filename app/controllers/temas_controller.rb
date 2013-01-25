class TemasController < ApplicationController
  
  def show
    @topic = Topic.find(params[:id])
    @iniciativas_response = Initiative.filters({'topic_ids' => [@topic.id]})    
    @iniciativas = @iniciativas_response.results
    @temas = Topic.all
    render 'iniciativas/index'
  end
end
