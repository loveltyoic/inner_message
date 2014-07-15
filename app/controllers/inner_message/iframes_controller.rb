require_dependency "inner_message/application_controller"

module InnerMessage
  class IframesController < ApplicationController
    include MessagesHelper
    before_action :sign_in_user
    
    def show
      @token = MessageToken.generate(current_user)
      @faye_server = YAML.load_file(File.join(Rails.root, 'config', 'faye_config.yml'))[ENV['RACK_ENV']]['faye_server']
    end
  end
end
