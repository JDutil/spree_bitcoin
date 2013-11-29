Spree::Core::Engine.routes.draw do
  # Add your extension routes here

  get '/coinbase', :to => "coinbase#invoice", :as => :coinbase_invoice
  post '/coinbase/notify', :to => "coinbase#notify", :as => :coinbase_notify

end
