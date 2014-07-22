Rails.application.routes.draw do
  root 'static_pages#home'

  resources :subjects, shallow: true do
  	resources :lessons, except: :index
  end
end
