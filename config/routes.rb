InstagramApp::Application.routes.draw do

  get "site/index"
  match 'user' => 'site#user'
  match 'u/:id' => 'users#show'
  match 'user-info' => 'site#user_info'
  match '/likes/' =>  'users#likes'
  match '/following/' => 'users#following'
  match '/followed-by/' => 'users#followed_by'
  match '/my-pics/' => 'users#my_pics'
  match '/logout/' => 'users#logout' 
  match '/nearby' => 'site#geo_tag_content'
  match '/search' => 'site#search'
  match '/relationship/:id' => 'users#relationship'
  match '/like-media' => 'users#like_media'
  match '/media/:id' => 'site#media'
  match '/comment/' => 'users#comment'
  match '/login' => 'site#login'
  match '/pagination' => 'site#pagination'
  match '/about' => 'site#about'
  match '/terms' => 'site#terms'
  match '/privacy' => 'site#privacy'
  match '/faq' => 'site#faq'
  match '/popular' => 'site#popular'
  match '/explore' => 'site#index'
  match 'admin' => 'site#admin'
  match 'joystagrammers' => 'users#joystagrammers'
  match '/profile_count/:id' => 'users#profile_count'
  match '/relation/:id' => 'users#relation'
  match '/browse-user/:id' => 'users#browse_user'
  match 'login-check' => 'users#login_check'
  match 'apparel' => 'site#apparel'
  # ------TAGS---------
  match '/tags' => 'tags#index'
  match '/tag/:id' => 'tags#show'

  # ------InterestingUser ----------
  resources :interesting_users
  get "/lay" => "interesting_users#lay"
  get "interesting_users/new"
  match '/create-user-post' => 'interesting_users#create_int_user_with_post'

  # ------InterestingUserPost ----------

  # ------Categories ----------
  resources :categories

  # ----------Media--------------
  match "likes/:id" => 'media#likes'
  match "comments/:id" => 'media#comments'



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
   root :to => 'site#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
