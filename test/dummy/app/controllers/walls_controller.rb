class WallsController < ApplicationController
  def index
    session[:current_user] = rand(10)
  end

  def create
    if InnerMessage::MessageBox.send_message(message_params.merge!({from_id: session[:current_user]}))
      render json: { status: 'success' }
    else
      render json: { status: 'error', message: "#{params[:message][:to_id]} does not exist!"}
    end      
  end

  private
  def message_params
    params.require(:message).permit(:content, :to_id)
  end
end
