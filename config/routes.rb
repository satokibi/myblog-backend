Rails.application.routes.draw do
  resources :tags
  resources :categories
  resources :posts
  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get    'users',  to: 'users#index'
  get    'users/:id', to: 'users#show', as: 'user'

  post   'api/auth', to: 'users#auth'
  get   'api/tags', to: 'tags#api_index'
  get   'api/categories', to: 'categories#api_index'
  get   'api/posts', to: 'posts#api_index'
  get   'api/posts/:id', to: 'posts#api_show'
end
