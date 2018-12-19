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

	root "welcome#index"
end
