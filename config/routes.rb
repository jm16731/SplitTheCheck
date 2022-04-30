Rails.application.routes.draw do
  #resources :comments
  #resources :favorites
  #resources :votes
  devise_for :users
  resources :restaurants

  get 'first' => "restaurants#first"
  get 'prev_10' => "restaurants#prev_10"
  get 'next_10' => "restaurants#next_10"
  get 'last' => "restaurants#last"
  get 'search' => "restaurants#search"
  get 'clear' => "restaurants#clear"
  patch 'thumbs_up' => "restaurants#thumbs_up"
  patch 'thumbs_down' => "restaurants#thumbs_down"
  patch 'thumbs_up/:id' => "restaurants#thumbs_up"
  patch 'thumbs_down/:id' => "restaurants#thumbs_down"

  root "restaurants#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
