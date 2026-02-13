Rails.application.routes.draw do
  

      devise_for :admin, skip: [:registrations, :password], controllers: {
        sessions: 'admin/sessions'
      }
      namespace :admin do
        get 'dashboards', to: 'dashboards#index'
        resources :users, only: [:destroy]
      end

      devise_scope :user do
        post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
      end

      devise_for :users, controllers:{
        registrations: "users/registrations"
      }
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

      scope module: :public do
        root to: "homes#top"
        get "about", to: "homes#about"
      
        resources :users, only: [:show] do 
          member do
            get :following
            get :followers
          end
        end

        get "search", to: "searches#search"
      
        resources :posts, only: [:index, :show, :new, :edit, :create, :destroy, :update] do
          resources :post_comments, only: [:create, :destroy, :edit, :update]
          resources :favorites, only: [:create, :destroy]
        end

        resources :relationships, only: [:create, :destroy]

      end
      

end
