Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  resources :items

  resources :warehouses

  namespace :admin do
    resources :items, only: [:index]
    resources :item_warehouses, only: [:create]
  end
end
