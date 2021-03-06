Rails.application.routes.draw do

  devise_for :admins, module: "admins"
  devise_for :customers, module: "customers"

  #以下、public関連のコントローラー/アクション関係設定

  root 'homes#top'
  get 'homes/about' => 'public/homes#about'

  namespace :public do

  resources :items, only: [:index, :show]

  resources :customers, only: [:show, :edit, :update]do
    collection do
      get 'unsubscribe'
      patch 'withdraw'
    end
  end

  resources :cart_items, only: [:index, :update, :destroy, :create] do
    collection do
      delete 'destroy_all'
    end
  end

  resources :orders, only: [:new, :index, :show, :create] do
    collection do
      post 'confirm'
      get 'complete'
    end
  end

  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  #以下、admin関連のコントローラー/アクション設定

  namespace :admin do
  get '/', to: 'homes#top'

  resources :items, only: [:index, :new, :create, :show, :edit, :update]

  resources :genres, only: [:index, :create, :edit, :update]

  resources :customers, only: [:index, :show, :edit, :update]

  get 'admin/orders/:id' =>'orders#show' ,  as: "admin_orders"
  patch 'admin/orders/:id' =>'orders#update'
  patch 'admin/order_details/:id' =>'order_details#update' , as: "admin_order_details"

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end