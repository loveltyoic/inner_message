InnerMessage::Engine.routes.draw do
  resources :messages do 
    member do 
      post 'read'
    end
  end
  resource :admin
  resource :iframe
end
