Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users,:controllers => {:registrations => "users/registrations",:sessions => "users/sessions",:confirmations => "users/confirmations",
    :passwords => "users/passwords",:unlocks => "users/unlocks"}
  resources :users do
    resources :tokens do
      member do
        
      end
      collection do 
        get :show_token_form
        post :redeem_token
      end
    end
    resource :profile
    resources :transactions
    member do
      get :shelf
      get :show_requested_books
      get :show_meeting_form
      post :submit_meeting_review
    end
    collection do 
      post :request_book
      
    end

  end



  resource :home do
      get :show_modal
      post :submit_form
      get :about_us ,as: 'about_us'
      get :privacy_policy, as: 'privacy_policy'
      get :terms_of_service, as: 'terms_of_service'
      # get '/about', to: 'static_pages#about', as: 'about'
    end

  resources :books do
    collection do
      get :library, :as => 'library'
      post :share
      get :search
    end
    member do
      get :edit_shared
      delete :delete_shared
      get :show_providers
      get :show_share_modal
    end

  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'books#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
