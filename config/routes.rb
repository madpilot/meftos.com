ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.signup '/urls/create', :controller => 'urls', :action => 'create'
  map.bookmarklets '/bookmarklets', :controller => 'pages', :action => 'bookmarklets'
  map.resources :users

  map.resource :session

  map.resources :urls
  map.resources :bookmarks, :collection => { :metadata => :post }, :member => { :delete => :get }

  map.connect 'bookmarks/tag/:tag', :controller => 'bookmarks', :action => 'index'
  map.connect ':permalink', :controller => 'urls', :action => 'show'

  map.root :controller => 'bookmarks', :action => 'index'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
