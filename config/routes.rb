Rails.application.routes.draw do
  resources :adaptive_thoughts
  resources :rebuttals
  resources :rebuttals
  resources :bases
  resources :automatic_thoughts
  resources :distortion_patterns
  resources :given_time_feelings
  resources :situations
  resources :feelings
  resources :feelings
  resources :co_independent_traits
  resources :adult_children_traits
  resources :cognitive_distortions
  resources :users

  resource :cognitive_therapy do
    get 'therapy_start/:id' => 'cognitive_therapy#therapy_start'
    get 'add_feeling/:situation_id/:feeling_id' => 'cognitive_therapy#add_feeling'
    get 'add_automatic_thought/:given_time_feeling_id' => 'cognitive_therapy#add_automatic_thought'
    post 'save_data' => 'cognitive_therapy#save_data'
  end

  resource :top do
    get 'diagnosis_start' => 'top#diagnosis_start'
    get 'diagnosis/:id/:yes_no' => 'top#diagnosis'
    #get 'user_policy' => 'top#user_policy'
    #get 'privacy_policy' => 'top#privacy_policy'
    #get 'developer_info' => 'top#developer_info'
    #get 'news' => 'top#news'
    #get 'about' => 'top#about'
    #get 'contact' => 'top#contact'
    #get 'news_by_mail' => 'top#news_by_mail'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'top#index'

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
