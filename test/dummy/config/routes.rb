Rails.application.routes.draw do
  root to: 'walls#index'
  mount InnerMessage::Engine => "/inner_message"
end
