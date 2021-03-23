Rails.application.routes.draw do
  get "about", to: "about#index"
  get "play/:id", to: "play#index", as: 'play'
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
