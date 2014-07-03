Rails.application.routes.draw do
  root to: 'walls#index'
  resources :walls
  mount InnerMessage::Engine => "/inner_message"
end
