Rails.application.routes.draw do

  controller :application do
    get :logout, action: :logout
    patch 'set_gender'
  end

  get 'about' => "welcome#about"

  resources :buildings, only: [:show], param: :slug, path: '' do
    resources :floors, only: [:show], param: :slug, path: '' do
      resources :restrooms, only: [:new, :create, :show, :destroy], param: :slug, path: '' do
        resources :reviews, only: [:new, :create, :edit, :update, :destroy]
      end
    end

    collection do
      get 'all-buildings' => :index, as: :all
      get :near_me
    end
  end

  root "welcome#index"
end
