Rails.application.routes.draw do
  devise_for :users

  get 'situations/start_recent_step1' => 'situations#start_recent_step1'
  get 'situations/create_as_empty/:occured_time/:mood_status' => 'situations#create_as_empty'
  get 'users/dashboard' => 'users#dashboard'
  get 'users/mood_monitor' => 'users#mood_monitor'
  get 'users/situations' => 'users#situations'
  get 'users/given_time_feeling_summary/:id' => 'users#given_time_feeling_summary'
  get 'situations/edit_modal/:id' => 'situations#edit_modal'
  get 'situations/edit_for_app/:id' => 'situations#edit_for_app'
  get 'situations/add_situation' => 'situations#add_situation'
  get 'automatic_thoughts/think/:id' => 'automatic_thoughts#think'
  get 'automatic_thoughts/think_deeply/:id' => 'automatic_thoughts#think_deeply'
  get 'automatic_thoughts/think_adaptively/:id' => 'automatic_thoughts#think_adaptively'
  get 'automatic_thoughts/progress_finished/:id' => 'automatic_thoughts#progress_finished'
  #自動思考、反証、根拠、適応的思考は、今の気持ち生成時に自動で生成されるので更新扱い
  patch 'automatic_thoughts/update_basis_and_rebuttal/:id' => 'automatic_thoughts#update_basis_and_rebuttal'
  patch 'automatic_thoughts/update_adaptive_thought/:id' => 'automatic_thoughts#update_adaptive_thought'



  resources :adaptive_thoughts
  resources :rebuttals
  resources :rebuttals
  resources :bases
  resources :automatic_thoughts
  resources :distortion_patterns
  resources :given_time_feelings
  resources :situations
  resources :feelings
  resources :co_independent_traits
  resources :adult_children_traits
  resources :cognitive_distortions
  resources :users

  resource :cognitive_therapy do
    get 'therapy_start/:id' => 'cognitive_therapy#therapy_start'
    get 'add_feeling/:id' => 'cognitive_therapy#add_feeling'
    get 'add_automatic_thought/:given_time_feeling_id' => 'cognitive_therapy#add_automatic_thought'
    post 'save_data' => 'cognitive_therapy#save_data'
  end

  resource :top do
    get 'diagnosis_start' => 'top#diagnosis_start'
    get 'diagnosis/:id/:yes_no' => 'top#diagnosis'
    # get 'user_policy' => 'top#user_policy'
    # get 'privacy_policy' => 'top#privacy_policy'
    # get 'developer_info' => 'top#developer_info'
    # get 'news' => 'top#news'
    # get 'about' => 'top#about'
    # get 'contact' => 'top#contact'
    # get 'news_by_mail' => 'top#news_by_mail'
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
