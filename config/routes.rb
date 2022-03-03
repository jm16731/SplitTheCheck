Rails.application.routes.draw do
  resources :restaurants

  get 'first' => "restaurants#first"
  get 'prev_10' => "restaurants#prev_10"
  get 'next_10' => "restaurants#next_10"
  get 'last' => "restaurants#last"

  root "restaurants#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
