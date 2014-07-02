module InnerMessage
  module ApplicationHelper
    def set_user
      @current_user ||= TempUser.create
    end

    def current_user
      @current_user
    end

    def destroy_user
      @current_user.delete
    end
  end
end
