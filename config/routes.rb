Gelfand::Application.routes.draw do
  get 'programs/:id/individuals_list' => 'programs#individuals_list'
  get 'programs/completed' => 'programs#completed'
  get 'programs/ongoing' => 'programs#ongoing'
  get 'programs/upcoming' => 'programs#upcoming'
  resources :programs

  # just need these 2 routes for creating a participant
  get 'participants', to: 'participants#index'
  post 'participants', to: 'participants#create'

  resources :individuals

  resources :organizations do
    collection do
      get 'org_overview'
    end
  end

  resources :bg_checks 

  #match 'organizations/overview' => 'organizations#overview', :via => [:get], :as => :org_overview

  # below is so I can add the 'delete_multiple' action and url along with the regular 7 we get from 
    # "resources :memberships"
  resources :memberships do
    collection do
      delete 'delete_multiple'
      post 'multiple_new'
    end
  end

    # need these 2 routes so do not receive GET or POST error for routes when creating an affiliation
  get 'affiliations', to: 'affiliations#index'
  post 'affiliations', to: 'affiliations#create'

  # need this route so can delete an affiliation
  delete 'affiliations/:id' => 'affiliations#destroy'

  # need this so can delete orgUser
  resources :org_users
  

  # this route is for the form in Org show page
  match '/organization_mailers',     to: 'organizations#send_sign_up_notice_if_no_indiv_exists',  via: 'post'

  match '/mailers',     to: 'mailers#new',             via: 'get'
  resources "mailers", only: [:new, :create]


  # Below ':controllers => ..." is so points to our custom 'registrations' controller
    # under my_devise folder which is in controllers folder
  devise_for :users, :controllers => {:registrations => "my_devise/registrations"} 
  root :to => "home#index"



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
