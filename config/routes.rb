Rails.application.routes.draw do
  namespace :public do
    resource :customers, only: [:show, :edit, :update]
    get 'customers/confirm'
    patch 'customers/withdrawal'
    resources :addresses, only: [:index, :edit, :create, :destroy]
    resources :orders, only: [:index, :new, :create, :show]
  end
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  root to: "homes#top"
  get 'homes/about' => 'homes#about' , as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end