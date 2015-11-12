Spree::Core::Engine.routes.draw do
  resources :stock_emails, only: :create
  namespace :admin do
    resources :stock_emails, :only => [:index]
  end
end
