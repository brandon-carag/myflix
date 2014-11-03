class ApplicationController < ActionController::Base
  protect_from_forgery
helper_method :current_user,:logged_in?,:require_login

def current_user
  @current_user||=User.find(session[:user_id]) if session[:user_id]
end

def logged_in?
  true unless current_user==nil
end

def require_login
  unless logged_in?
    flash[:warning]="Please login to take this action."
    redirect_to sign_in_path
  end
end

def admin?
  current_user.admin == true
end

def require_admin
  if current_user.admin? == false
    flash[:danger] = "The credentials supplied are not authorized to access this page"
    redirect_to root_path 
  end
end

end
