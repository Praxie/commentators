Commentators::Application.routes.draw do
  get "omniauth_callbacks/vkontakte"
  get "users/controller"
  resources :images do
    member do
      post :godnota
      post :vote_up
      post :vote_down
    end
  	resources :comments do
  		member do
        post :vote_up
        post :vote_down
      end
    end
  end

  resources :news do
    member do
      post :godnota
      post :vote_up
      post :vote_down
    end
    resources :comments do
      member do
        post :vote_up
        post :vote_down
      end
    end
  end

  resources :facts do
    member do
      post :godnota
      post :vote_up
      post :vote_down
    end
    resources :comments do
      member do
        post :vote_up
        post :vote_down
      end
    end
  end

  resources :fictions do
    member do
      post :godnota
      post :vote_up
      post :vote_down
    end
    resources :comments do
      member do
        post :vote_up
        post :vote_down
      end
    end
  end

  resources :stories do
    member do
      post :godnota
      post :vote_up
      post :vote_down
    end
    resources :comments do
      member do
        post :vote_up
        post :vote_down
      end
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", :registrations => "registrations" }
  resources :users
  get '/dniwe', to: 'home#dniwe', as: :dniwe
  get '/best', to: 'home#best', as: :best
  root 'home#index'
end
