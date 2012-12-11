Usrshare::Application.routes.draw do
  get "searches/index"

  resources :subcategories, :except => [ :show ]

  resources :categories, :except => [ :show ] do
    collection do
      post 'import'
      get 'export'
      get 'check'
      get 'labels'
    end
  end



  resources :posts
  devise_for :users
  resources :users , :only => [ :index ]
  resources :checkins
  match '/members/new' => 'members#disabled'
  resources :members do
    collection do
      get 'disabled'
      get 'onboard'
    end
  end
  resources :events
  resources :rooms
  resources :locations
  resources :recommendations do
    post 'upvote'
    post 'downvote'
  end
  resources :media_locations
  resources :publishers
  resources :authors
  resources :media_types
  resources :searches
  resources :media do
    collection do
      get 'search'
      post 'scan'
      get 'scan'
      get 'categorize'
      post 'import'
      get 'inventory'
      post 'inventory'
      get 'labels'
      post 'labels'
      get 'quick_labels'      
    end
  end
  resource :contact, :controller => 'contact'
  match '/admin' => 'pages#admin'
  match '/reservation_policy' => 'pages#reservation_policy'  
  match '/share' => 'pages#share', :as => :share_page

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
  root :to => "pages#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
