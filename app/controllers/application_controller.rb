class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  	def current_user
      @current_user ||= (User.find_by( auth_token: cookies[:auth_token] ) rescue nil) if cookies[:auth_token]
    end
    def current_user=(user)
      @current_user = user
    end

    def logged_in?
      !!current_user
    end

    def auto_login(user)
      @current_user = user
      cookies.delete(:auth_token)
      reset_session # protect from session fixation attacks
      form_authenticity_token
      user.save if user.auth_token.nil? # don't like this, just temporary
      cookies.permanent[:auth_token] = user.auth_token
      current_user
    end

    def logout
      if logged_in?
        @current_user.update_attribute(:auth_token, nil)
        cookies.delete(:auth_token)
        reset_session
        @current_user = nil
      end
    end

    def require_login
      if !logged_in?
        store_location
        redirect_to root_url
      end
    end

    def require_no_login
      logout if logged_in?
    end

    def store_location
      session[:return_to] = if request.get?
        request.url
      else
        request.referer
      end
    end

    def redirect_if_logged_in
      if current_user
        redirect_to search_path
      end
    end

    def redirect_back_or_to(url = root_url, options={})
      redirect_to(session.delete(:return_to) || url, options)
    end

  	helper_method :current_user, :logged_in?
end
