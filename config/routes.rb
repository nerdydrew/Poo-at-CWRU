Rails.application.routes.draw do

  controller :application do
    get :logout, action: :logout
    patch 'set_gender'
  end

  resources :buildings, only: [:show], param: :slug, path: '' do
    resources :floors, only: [:show], param: :slug, path: '' do
      resources :toilets, only: [:new, :create, :show], param: :slug, path: '' do
        resources :reviews, only: [:new, :create, :edit, :update, :destroy]
      end
    end

    collection do
      get :near_me
    end
  end

  root "welcome#index"
end
