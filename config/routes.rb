Rails.application.routes.draw do
  
  root 'dashboard#home'
  get 'dashboard/home_page', to: 'dashboard#home_page'
  

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :post_comments, only: [:create]
  resources :profiles, only: [:show]
  resources :friendships, only: [:index, :destroy] do
    member do
      get 'add_friend'
      delete 'turn_down'
    end
    collection do
      get 'your_friends', 'pending_requests', 'accept_request'
    end
  end

  resources :posts, only: [:create] do
    collection do
      get 'add_post_like'
    end
  end
  

  get   '/staticpages/home',   to: 'staticpages#home'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
