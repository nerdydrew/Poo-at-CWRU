class UsersController < ApplicationController

  def set_gender
    user = User.find_or_create_by(case_id: session[:cas_user])
    user.update(:gender => params.require(:gender))
    redirect_back(fallback_location: root_path)
  end
end
