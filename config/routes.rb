Rails.application.routes.draw do
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    get '/customers/confirm' => 'customers#confirm', as: "confirm"
    patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    resource :customers, only:[:show, :edit, :update]
    resources :items, only:[:index, :show]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only:[:index, :create, :destroy, :update]
    resources :addresses, only:[:index, :create, :edit, :update, :destroy]
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/complete' => 'orders#complete'
    resources :orders, only:[:new, :create, :index, :show]
  end
  
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root to: 'homes#top'
    resources :genres, only:[:new, :create, :index, :edit, :update]
    resources :items, only:[:new, :create, :index, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :order, only:[:show, :update]
    
  end
  
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
