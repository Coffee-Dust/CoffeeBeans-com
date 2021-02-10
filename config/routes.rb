Rails.application.routes.draw do
  root 'welcome#home'
  
  resources :users, except: [:index] do
    resources :posts, path: "beans", except: [:index]
  end

  get 'login', to: 'sessions#new'
  post 'logout', to: 'sessions#destroy'
  resources :sessions, only: [:create]
  #for omniauth
  match '/auth/:provider/callback', to: "sessions#omni_auth_create", via: [:get, :post]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
