class UsersController < ApplicationController

  before_action( :signed_in_user, only: [ :index, :show ] )
  before_action( :check_admin, only: [ :index ] )

  def index
    @users = User.all
  end

  def show
    if( is_admin? )
      @user = User.find( params[ :id ] )
    else
      @user = @current_user
    end
  end

  private
    def check_admin
      redirect_to( root_url ) unless is_admin?
    end



end
