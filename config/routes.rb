Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    resources :customers, only:[:show]
    resources :items, only:[:index, :show]
    resources :cart_items, only:[:index]
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :genres, only:[:new, :create, :index, :edit, :update]
    resources :items, only:[:new, :create, :index, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :order, only:[:show, :update]
  end
  
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
