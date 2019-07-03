Rails.application.routes.draw do
  root 'staticpages#home'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
