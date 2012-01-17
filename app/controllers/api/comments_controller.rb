class Api::CommentsController < ApplicationController
  def create
    ReceiveEmail.new.create_comments
    render :text => ""
  end
end
