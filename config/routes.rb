Spree::Core::Engine.routes.draw do

  resources :variants, :only => [] do
    resources :stock_emails, :only => [:new, :create]
  end

  namespace :admin do
    resources :stock_emails, :only => [:index]
  end
end
