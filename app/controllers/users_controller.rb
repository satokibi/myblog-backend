class UsersController < ApplicationController

  before_action( :signed_in_user, only: [ :index, :show ] )

  def index
    @users = User.all
  end

  def show
    @user = User.find( params[:id] )
  end

  private
    def signed_in_user
      unless signed_in?
        flash[:danger] = "Please log in."
        redirect_to( login_url )
      end
    end

end
