Rails.application.routes.draw do
  get 'static_pages/home'
  root 'sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get    'users',  to: 'users#index'
  get    'users/:id', to: 'users#show', as: 'user'
end
