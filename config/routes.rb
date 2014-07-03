InnerMessage::Engine.routes.draw do
  resources :messages
  resource :admin
  resource :iframe
end
