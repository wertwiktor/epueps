Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'

  resources :subjects, only: [:index, :show] do
    get 'info'
  end 

  namespace :admin do
    resources :users
    resources :subjects do
      resources :lessons, except: [:index] do
        resources :videos, except: [:show, :index] 
      end
    end

    match '/', to: 'admin_pages#home', via: :get
  end

  resources :articles

end
