class ApplicationController < ActionController::Base
  before_action CASClient::Frameworks::Rails::GatewayFilter, :except => [ :set_gender ]
  before_action :check_login
  before_action :set_timezone

  def check_login
    @logged_in = session[:cas_user].present?

    if @logged_in
      @case_id = session[:cas_user]
    end

    @gender = cookies[:gender] || Restroom.genders[:any]
  end

  def set_gender
    gender = params.require(:gender)
    if gender == Restroom.genders[:male] || gender == Restroom.genders[:female]
      cookies[:gender] = gender
    else
      cookies.delete :gender
    end

    # Note that CAS's redirect messes with this if logged out, so exclude this method from it.
    redirect_back(fallback_location: root_path)
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

  def set_timezone
    Time.zone = "America/New_York"
  end
end
