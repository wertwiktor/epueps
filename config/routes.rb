Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'

  resources :subjects, only: [:index, :show] do
    get 'info'
  end 

  namespace :admin do
    resources :users
    resources :subjects do
      resources :lessons, except: [:index, :show]
    end

    match '/', to: 'admin_pages#home', via: :get
  end

end
