module InnerMessage
  class OperatorsController < ActionController::Base    
    # before_action :check_permission, only: [:reply, :show]
    layout 'inner_message/operator'
    def index
      @operators = Operator.all
    end

    def show
      @operator_session_key = Operator.find(params[:id]).session_key
      @operator_id = params[:id]
      @faye_server = CONFIG['faye']['server']
    end

    def create
      @operator = Operator.create
      render json: @operator
    end

    def reply
      @operator = Operator.find(params[:id])
      @msg = @operator.send_message(content: params[:content], to_id: params[:visitor_id])
      render json: @msg
    end

    private
    def check_permission
      render 403 unless session[:operator_ids].include? params[:id]
    end
  end
end
