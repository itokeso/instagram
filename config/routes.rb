Rails.application.routes.draw do
  devise_for :users,  controllers: { registrations: 'registrations' } 
  
  root "posts#index"
  resources :users , only: [:show]

  resources :posts  do
    resources :photos, only: [:new, :create]
    resources :likes,  only: [ :create , :destroy ]
  end

end
