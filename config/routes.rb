Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'

  resources :subjects, shallow: true do
  	resources :lessons, except: :index
  end	
end
