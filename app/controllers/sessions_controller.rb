class SessionsController < ApplicationController
	
  def create
    auth_hash = request.env['omniauth.auth']
    user = User.update_or_create_with_omniauth(auth_hash)
    auto_login(user)
    redirect_to search_url, notice: "Signed in!"
  end

  def failure
    redirect_to root_url, :alert => "Authentication failed, please try again."
  end

  def destroy
    logout
    redirect_to root_url
  end

end
