Rails.application.routes.draw do
  get 'board/list'

    devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
#    get 'auth/:provider/callback', to: 'sessions#create'
#    get 'auth/failure', to: redirect('/')
#    get 'signout', to: 'sessions#destroy', as: 'signout'
#
#    resources :sessions, only: [:create, :destroy]
#    resource :home, only: [:show]

    #root to: "home#show"
  get '/users/sign_out' => 'devise/sessions#destroy'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'home/show'
  get 'facebook/login'
  get 'home/nopage'
  get '/mygrade' => 'home#mygrade'

  #게시판 관련
  get '/board' => 'board#list'
  get '/board/new_post' => 'board#new_post'
  get '/board/view_post/:id' => 'board#view_post'
  post '/board/upload_post' => 'board#upload_post'
  post '/board/reply_write' => 'board#reply_write'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#search'

  # Example of regular route:
    get '/' => 'home#search'
    get '/input' => 'home#index'
    post '/input' => 'home#input'
    post '/point' => 'home#point'
    get '/list' => "home#list"
    
    #routes for update database
    get '/update' => 'update#update'
    get '/update_minor' => 'updata#update_minor'
    get '/update_dept' => 'update#update_dept'
    
    get '/univ_list' => 'home#univlist'
    get '/nav_univ_list' => 'home#nav_univ_list'
    #get '/univ_add/:univ_name' => 'home#univ_add'
    get '/univ_add' => 'home#univ_add'
    
    get '/index_dept' => 'home#index_dept'
    
    get '/nopage' => 'home#nopage'
    get '/list/:id' => 'home#list', :constraints => {:id => /[^\/]+/}
    get '/search' => 'home#search'
    #get '/login' => 'facebook#login'
    
  #routes for server management
    get '/delete/:email' => 'supervisor#delete_user', :constraints => {:email => /[^\/]+/}
    
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  # Example resource route with options:
  #     member do
        
  #       post 'toggle'

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
