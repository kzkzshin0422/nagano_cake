Rails.application.routes.draw do
  namespace :admin do
    resources :items, only: [:new, :index, :show, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    get '/' => "homes#top" , as: '/'
  end
  scope module: :public do
    resource :customers, only: [:show, :edit, :update]
    get 'customers/confirm'
    patch 'customers/withdrawal'
    resources :addresses, only: [:index, :edit, :create, :destroy]
    resources :orders, only: [:index, :new, :create, :show]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update]
    root to: "homes#top"
    get 'about' => 'homes#about' , as: 'about'
  end
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
