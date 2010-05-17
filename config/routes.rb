ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => "users" do |user|
    user.subscribe  "/inscricao", :action => "subscribe", :conditions => { :method => :get }
    user.subscribe_event  "/inscricao_evento/:envent/:user/:token", :action => "subscribe_event", :conditions => { :method => :get }
    user.users      "/", :action => "index", :conditions => { :method => :get }
    user.connect    "/", :action => "create", :conditions => { :method => :post }
  end
end
