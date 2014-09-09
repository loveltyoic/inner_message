InnerMessage::Engine.routes.draw do
  resources :messages do
    member do
      post 'read'
      post 'reply'
    end
  end
  resource :admin do
  end
  resource :iframe, only: [:show] do
    get 'channels'
  end
  resource :chat, only: [:show, :create]

  resources :channels do
    member do
      get 'broadcasts'
    end
  end
  resources :broadcasts

  resources :operators do
    member do
      post 'reply'
    end
  end

  resources :broadcasts do
    collection do
      get 'read_count'
    end
  end
end
