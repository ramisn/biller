BillerBot::Application.routes.draw do
  

  resources :holidays

  match '/payments/payment', :to => 'payments#payment', :as => 'paymentspayment', :via => [:get]

  match '/payments/relay_response', :to => 'payments#relay_response', :as => 'payments_relay_response', :via => [:post]

  match '/payments/receipt', :to => 'payments#receipt', :as => 'payments_receipt', :via => [:get]


  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users
  resources :products do
    resources :product_contexts
    collection do
      put "apply_price"
    end
  end 
 resources  :invoices do 
  get "find" 
   collection do
  post "invoicestatus" 
 end
   collection do
      post "lineitems" 
    end
    collection do 
    get "find"
    
   end 
   collection do
   get "find_context"
   end
   collection do 
    get "test"
   end
 end

  #end
  #resources :account_contacts #, :as => :contacts, :path => :contacts
  resources :accounts do
    
    resources :account_contacts, :as => :contacts, :path => :contacts
    #  resources :invoices  do 
    #    member do
    #   post "lineitems" 
    # end 

 # end
end
  resources :dashboard, :only => [:index]
  root :to=> "dashboard#index"
  # match ':controller(/:action(/:id(.:format)))'
#match ': controller (/: action (/: id (.: format)))'
end
