class WallsController < ApplicationController
  def index
    session[:current_user] = Player.create.id
  end

  def create
    current_user = Player.find(session[:current_user])
    if current_user.send_message({to_id: session[:current_user], content: "Hello, I am code name #{current_user.id}"})
      render json: {status: 'success'}
    else
      render json: {status: 'error'}
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :to_id)
  end
end
