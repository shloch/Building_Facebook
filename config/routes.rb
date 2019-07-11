Rails.application.routes.draw do
  #resources :users
  get 'posts/index'
  get 'posts/create'
  get 'posts/new'
  get 'posts/edit'
  get 'posts/update'
  root 'dashboard#home'
  get 'dashboard/home_page', to: 'dashboard#home_page'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users
  resources :post_comments
  resources :friendships, except: [:create, :update, :show] do
    member do
      get 'add_friend' 
    end
    collection do
      get 'your_friends', 'pending_requests'
    end
  end

  resources :posts do
    collection do
      get 'add_post_like'
    end
  end
  

  get   '/staticpages/home',   to: 'staticpages#home'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
