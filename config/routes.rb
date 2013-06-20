Altar::Application.routes.draw do

  get "users/new"

  get "users/create"

  get "users/show"

  get "users/edit"

  get "users/update"

  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks",:registrations => "registrations"}

  resources :users, only: [:new,:show, :edit, :update]

  resources :workshops

  resources :categories

  get "home/index"
  
 # get "home/users" as
  get '/users', :to => 'home#users', :as => :users
  get '/artist/:id/profile', :to => 'home#artist_profile', :as => :artist_profile
  get "/upvote_product/:id", :to => 'home#upvote_product', :as => :upvote_product
  get "/downvote_product/:id", :to => 'home#downvote_product', :as => :downvote_product
  get "products/:id/upvote_product", :to => 'home#upvote_product', :as => :upvote_product
  get "products/:id/downvote_product", :to => 'home#downvote_product', :as => :downvote_product


  resources :products
  
  
  #agregar comentarios
  match "/home/add_new_comment" => "home#add_new_comment", :as => "add_new_comment", :via => [:post]

  # facebook connect
  # match '/auth/:provider/callback' => 'omniauth_callbacks#facebook'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'
  
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
