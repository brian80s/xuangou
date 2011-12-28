Xuangou::Application.routes.draw do
  resources :messages

  resources :cheers

  resources :flags

  resources :comments

  resources :topics do
    get :get_new_topic,:get_last_topic,:on=>:collection
  end

  resources :categories

  resources :users do
    get :info ,:on=>:member
    get :user_center,:on=>:collection
  end
  #  match "/login"=>"user_sessions#new"
  #  match "/logout"=>"user_sessions#destroy"
  get "login", :controller => "user_sessions", :action => "new"
  get "logout", :controller => "user_sessions", :action => "destroy"
  resource :account, :controller => 'users' 
  resources :user_sessions

  
  resources :system_log do
    get :index,:clear,:change_level,:on=>:collection
  end
  match "/main"=>"main#index"
  root :to=>"main#index"
#  resources :account do
#    member do
#      get "authenticated","admin","setting_update","setting"
#    end
#    collection do
#      get "search","filter","signup","login","logout","index"
#      post "login","signup","search"
#    end
#  end
  #  match "/login"=> "account#login"
  #  match "/logout"=> "account#logout"
  namespace :b do 
    resources :operates
  end
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
