module SessionsHelper

  def current_user
    remember_token = User.encrypt( cookies[:user_remember_token] )
    @current_user ||= User.find_by( remember_token: remember_token )
  end

  def sign_in( user )
    remember_token = User.new_remember_token
    cookies.permanent[ :user_remember_token ] = remember_token
    user.remember( remember_token )
  end

  def sign_out
    cookies.delete( :user_remember_token )
    @current_user.forget()
    @current_user = nil
  end

  def signed_in?
    current_user().present?
  end

  def signed_in_user
    unless signed_in?
      flash[:danger] = "Please log in."
      redirect_to( login_url )
    end
  end

  def is_admin?
    current_user.admin
  end

end
