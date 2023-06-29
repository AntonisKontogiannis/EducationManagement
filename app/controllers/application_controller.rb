class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    
    def current_user
        p "current_user"
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        p "login check"
        !!current_user #returns to a boolean
    end

    def require_user
        if !logged_in?
            redirect_to login_path
        end
    end
end
