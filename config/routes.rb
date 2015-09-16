Rails.application.routes.draw do
  root 'welcome#index'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'


  resources :users do
    resources :posts do
      resources :comments
    end
  end

  get '/posts', to: 'posts#index', as: 'posts'

  post '/follow/:id', to: 'users#follow', as: 'follow_user'

  post '/unfollow/:id', to: 'users#unfollow', as: 'unfollow_user'

  get '/user/:id/following', to: 'users#following', as: 'following'

  get '/user/:id/followers', to: 'users#followers', as: 'followed'
end
