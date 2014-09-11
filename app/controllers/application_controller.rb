class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  	def redirect_if_logged_in
  		if false
  			redirect_to search_path
  		end
  	end

  	def current_user
  		nil
  	end

  	helper_method :current_user
end
