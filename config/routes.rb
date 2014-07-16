Rails.application.routes.draw do
  root "projects#index"
  
  namespace :admin do
    root :to => "base#index"
    resources :users do
      resources :permissions
      put "permissions", to: "permissions#set", as: "set_permissions"
    end
    resources :states
  end

  get 'users/new'
  get 'users/create'
  get 'users/show'
  
  get '/signin', to: "sessions#new"
  post '/signin', to: "sessions#create"
  delete '/signout', to: "sessions#destroy", as: "signout"

  resources :projects do
    resources :tickets
  end
  
  resources :tickets do
    resources :comments
  end
  
  resources :users
  
  resources :files
  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
