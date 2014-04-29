Gelfand::Application.routes.draw do
  resources :programs
  get 'programs/:id/individuals_list' => 'programs#individuals_list'

  resources :individuals

  resources :organizations

  resources :bg_checks 

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
  
  # http://stackoverflow.com/questions/5631145/routing-to-static-html-page-in-public
  # I put 'gelfand_contact_page.html' file inside the public folder

  match '/mailers',     to: 'mailers#new',             via: 'get'
  resources "mailers", only: [:new, :create]


  devise_for :users
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
