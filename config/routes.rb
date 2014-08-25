InnerMessage::Engine.routes.draw do
  resources :messages do
    member do
      post 'read'
      post 'reply'
    end
  end
  resource :admin
  resource :iframe, only: [:show]
  resource :chat, only: [:show, :create]
  resources :broadcasts do
    collection do
      get 'read_count'
    end
  end
end
