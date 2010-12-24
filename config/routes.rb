ActionController::Routing::Routes.draw do |map|
  map.mom '/mom', :controller => 'invites', :action => 'show', :id => '9e37d24bbb20e3f5eaf1c0764c0ca20b'
  map.dad '/dad', :controller => 'invites', :action => 'show', :id => '562b9398f1a50bbb3fb522ed62c266cf'
  map.delete_answer '/answers/:id', :controller => 'answers', :action => 'delete', :conditions => { :method => :delete }
  map.add_email '/users/email', :controller => 'users', :action => 'email'
  map.your_answers '/prompts/answered', :controller => 'prompts', :action => 'answered'
  map.prompt_list '/prompts/list', :controller => 'prompts', :action => 'list'
  map.resources :prompts
  map.resources :users
  map.resources :sessions, :only => [:new, :create, :destroy]
  map.resources :invites, :only => [:new, :create, :show]
  map.invite_accept '/invites/:id/accept', :controller => 'invites', :action => 'accept', :conditions => { :method => :post }

  map.signin '/signin', :controller => 'sessions', :action => 'new'
  map.signout '/signout', :controller => 'sessions', :action => 'destroy'
  map.signup '/signup', :controller => 'users', :action => 'new'

  map.home '/home', :controller => 'prompts', :action => 'index'
  map.root :controller => 'prompts', :action => 'index'
  
  map.answer '/prompts/:id/answer', :controller => 'prompts', :action => 'answer', :conditions => { :method => :post }
  map.user_answers '/user/:id/answers', :controller => 'users', :action => 'answers'
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
