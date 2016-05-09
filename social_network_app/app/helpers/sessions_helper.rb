module SessionsHelper
  def log_in(person)
    session[:user_id] = person.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # returnts current_user if any
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= Person.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = Person.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
