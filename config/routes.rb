Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    resources :items, only: [:new, :index, :show, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    get '/' => "homes#top" , as: '/'
    resources :orders, only: [:show]
  end
  scope module: :public do
    get 'customers' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/confirm'
    patch 'customers/withdrawal'
    resources :addresses, only: [:index, :edit, :create, :destroy]
    post 'orders/confirm'
    get 'orders/complete'
    resources :orders, only: [:index, :new, :create, :show]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do 
        delete "destroy_all"
      end
    end
    root to: "homes#top"
    get 'about' => 'homes#about' , as: 'about'
  end
  

  

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
