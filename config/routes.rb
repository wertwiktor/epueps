Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'

  resources :subjects, only: [:index, :show], shallow: true do
    get 'info'
    resources :lessons, only: [:show]
  end 

  namespace :admin do
    resources :users
    resources :subjects, except: [:show] do
      resources :lessons, except: [:index, :show]
    end

    match '/', to: 'admin_pages#home', via: :get
  end

end
