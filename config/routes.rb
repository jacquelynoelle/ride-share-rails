Rails.application.routes.draw do
  root "drivers#index"

  resources :trips, except: [:new, :destroy]

  resources :drivers

  resources :passengers do
    resources :trips, only: [:create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
