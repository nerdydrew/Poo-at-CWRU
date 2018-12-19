Rails.application.routes.draw do

	controller :application do
		get :logout, action: :logout
	end

	root "welcome#index"
end
