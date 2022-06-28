Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  resources :tasks do 
    member do
      patch :toggle
    end
  end
  root to: 'tasks#index'
end
