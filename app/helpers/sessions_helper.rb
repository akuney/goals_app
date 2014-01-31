module SessionsHelper

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
    @current_user
  end

  def logged_in?
    !!current_user
  end

end
