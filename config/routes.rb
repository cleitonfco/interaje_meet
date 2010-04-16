ActionController::Routing::Routes.draw do |map|
  map.resources :events
  map.with_options :controller => "users" do |user|
    user.subscribe  "/evento/:slug/inscricao", :action => "subscribe", :conditions => { :method => :get }
    user.users      "/evento/:slug", :action => "index", :conditions => { :method => :get }
    user.connect    "/evento/:slug", :action => "create", :conditions => { :method => :post }
  end
end
