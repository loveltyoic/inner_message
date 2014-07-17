require_dependency "inner_message/application_controller"

module InnerMessage
  class IframesController < ApplicationController
    def show
      @token = MessageToken.generate(current_user_id)
      @faye_server = YAML.load_file(File.join(Rails.root, 'config', 'faye_config.yml'))[ENV['RACK_ENV']]['faye_server']
    end
  end
end
