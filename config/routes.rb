InstagramApp::Application.routes.draw do
  get "users/new"

  get "site/index"
  get 'user' => 'site#user'
  get 'u/:id' => 'users#show'
  get 'user-info' => 'site#user_info'
  get '/likes/' =>  'users#likes'
  get '/following/' => 'users#following'
  get '/followed-by/' => 'users#followed_by'
  get '/my-pics/' => 'users#my_pics'
  get '/logout/' => 'users#logout' 
  get '/nearby' => 'site#geo_tag_content'
  get '/search' => 'site#search'
  get '/relationship' => 'users#relationship'
  get '/like-media' => 'users#like_media'
  get '/media/:id' => 'site#media'
  get '/comment/' => 'users#comment'
  get '/login' => 'site#login'
  get '/pagination' => 'site#pagination'
  get '/about' => 'site#about'
  get '/popular' => 'site#popular'
  get '/explore' => 'site#index'
  get 'admin' => 'site#admin'
  get 'joystagrammers' => 'users#joystagrammers'
  # ------TAGS---------
  get '/tags' => 'tags#index'
  get '/tag/:id' => 'tags#show'

  # ------InterestingUser ----------
  resources :interesting_users
  get "/lay" => "interesting_users#lay"
  get "interesting_users/new"
  get '/create-user-post' => 'interesting_users#create_int_user_with_post'

  # ------InterestingUserPost ----------

  # ------Categories ----------
  resources :categories





  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   get 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
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
   root :to => 'site#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # get ':controller(/:action(/:id))(.:format)'
end
