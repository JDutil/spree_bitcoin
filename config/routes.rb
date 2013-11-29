Spree::Core::Engine.routes.draw do
  # Add your extension routes here

  post '/coinbase', :to => "coinbase#invoice", :as => :coinbase_invoice
  get '/coinbase/notify', :to => "coinbase#notify", :as => :coinbase_notify

end
