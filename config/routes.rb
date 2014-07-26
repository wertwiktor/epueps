Rails.application.routes.draw do
  root 'static_pages#home'

  resources :subjects, shallow: true do
  	get 'popular', action: 'index_most_popular', as: 'most_popular', on: :collection
  	get 'recent', action: 'index_most_recent', as: 'most_recent',
  		on: :collection
  	resources :lessons, except: :index
  end	
end
