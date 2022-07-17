Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins
  get 'addresses/index'
  get 'addresses/edit'
  get 'orders/new'
  get 'orders/index'
  get 'orders/show'
  get 'orders/confirm'
  get 'orders/complete'
  get 'cart_items/index'
  get 'customers/show'
  get 'customers/edit'
  get 'customers/confirm'
  get 'customers/withdraw'
  get 'items/index'
  get 'items/show'
  devise_for :users
  root to: 'homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
