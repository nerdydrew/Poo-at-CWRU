class ApplicationController < ActionController::Base
  before_action :check_login
  before_action :set_timezone

  def check_login
    @logged_in = request.session['cas'].present? && request.session['cas']['user'].present?

    if @logged_in
      @case_id = request.session['cas']['user']
    end

    @gender = cookies[:gender] || Restroom.genders[:any]
  end

  def require_login
    if !@logged_in
      # rack-cas redirects this to the CAS login page.
      head :unauthorized
    end
  end

  def set_gender
    gender = params.require(:gender)
    if gender == Restroom.genders[:male] || gender == Restroom.genders[:female]
      cookies[:gender] = gender
    else
      cookies.delete :gender
    end

    redirect_back(fallback_location: root_path)
  end

  # Manually build these because rack-cas doesn't seem to have them.
  def login
    destination = request.referer || "#{request.protocol}#{request.host_with_port}"
    redirect_to "#{RackCAS.config.server_url}?service=#{destination}"
  end

  def logout
    destination = request.referer || "#{request.protocol}#{request.host_with_port}"
    redirect_to "#{RackCAS.config.server_url}/logoutayy?redirect=#{destination}"
  end

  def set_timezone
    Time.zone = "America/New_York"
  end
end
