class WallsController < ApplicationController
  def index
    session[:current_user] = rand(1..10)
  end

  def create
    current_user = Player.find(session[:current_user])
    if current_user.send_message({to_id: rand(1..10), content: "Hello, I am code name #{current_user.id}"})
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
