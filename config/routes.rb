Rails.application.routes.draw do
  root 'welcome#index'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'


  resources :users, except: [:show] do
    resources :posts do
      resources :comments
    end
  end

  get '/profile/:username', to: 'users#show', as: 'profile'

  # get '/user/:username/edit', to: 'users#edit', as:

  get '/posts', to: 'posts#index', as: 'posts'

  post '/follow/:username', to: 'users#follow', as: 'follow_user'

  post '/unfollow/:username', to: 'users#unfollow', as: 'unfollow_user'

  get '/profile/:username/following', to: 'users#following', as: 'following'

  get '/profile/:username/followers', to: 'users#followers', as: 'followed'
end
