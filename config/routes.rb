Rails.application.routes.draw do
  resources :comments
  resources :communities
  resources :posts
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

  get 'producers' => "pages#producers"

  get 'about' => "pages#about"

  get 'requests' => "pages#requests"

  get 'welcome' => "pages#welcome"

  get 'setup' => "pages#setup"

  post 'community_setup' => "communities#community_setup"

  get 'dashboard' => "pages#dashboard"

  get 'votes' => "pages#votes"

  get 'balance' => "pages#balance"

  get '/post/:post_id/up_vote', :to => 'posts#up_vote'

  get '/post/:post_id/down_vote', :to => 'posts#down_vote'

  get '/comment/:comment_id/up_vote', :to => 'comments#up_vote'

  get '/comment/:comment_id/down_vote', :to => 'comments#down_vote'

  get '/click/:post_id/:position', :to => 'posts#click'

  #devise_for :users, :path_names => { :sign_up => "signup", :sign_in => "login", :edit_registration => "settings"}

  get '/:url_name/' => 'communities#profile', as: 'community_page'

  get '/user/:username/' => 'pages#profile_page', as: 'profile_page'

  get '/user/follow/:followingID', :to => 'pages#follow'

  get '/user/community/follow/:followingID', :to => 'pages#follow_community'

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
