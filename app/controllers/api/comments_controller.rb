class Api::CommentsController < ApplicationController
  def create
    ReceiveEmail.new.create_comments
  end
end
