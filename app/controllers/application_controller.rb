class ApplicationController < ActionController::Base
	before_action CASClient::Frameworks::Rails::GatewayFilter
	before_action :check_login

	def check_login
		@logged_in = session[:cas_user].present?
		if @logged_in
			@username = session[:cas_user]
		end
	end

	def logout
		CASClient::Frameworks::Rails::Filter.logout(self)
	end
end
