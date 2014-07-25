Rails.application.routes.draw do
  root 'static_pages#home'

  resources :subjects, shallow: true do
  	member do
  		get 'toggle_scope'
  	end
  	resources :lessons, except: :index
  end	
end
