Rails.application.routes.draw do

  mount InnerMessage::Engine => "/inner_message"
end
