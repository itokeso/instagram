Rails.application.routes.draw do
  devise_for :users,  controllers: { registrations: 'registrations' } 
  
  root "pages#index"
  resources :users , only: [:show]
end
