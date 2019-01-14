class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by( mail: params[:session][:mail].downcase )
    if( user && user.authenticate(params[:session][:password]) )
      sign_in( user )
      flash[:success] = "Welcome"
      redirect_to( user_path( user.id ) )
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render( 'new' )
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to( root_url )
  end

end
