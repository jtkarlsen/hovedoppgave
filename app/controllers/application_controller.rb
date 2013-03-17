class ApplicationController < ActionController::Base
  #include Authentication
  
  protect_from_forgery
  
  helper :all
  
  helper_method :set_current_user, :current_user_session, :current_user 

  before_filter { |c| Authorization.current_user = c.current_user }
  
  #private
  def set_current_user
    Authorization.current_user = current_user 
  end
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to users_url # TODO: change this to the main page
        return false
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def permission_denied
      if current_user
        render :template => 'shared/access_denied'
      else
        flash[:notice] = 'Access denied. Try to log in first.'
        redirect_to login_path
      end
    end    
end