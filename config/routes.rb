Rails.application.routes.draw do

	resources :users, only: [] do
		member do
			patch :set_gender
		end
	end
	patch 'set_gender', to: 'users#set_gender'


	controller :application do
		get :logout, action: :logout
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
