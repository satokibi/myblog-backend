class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action( :signed_in_user, except: [:api_index] )
  protect_from_forgery :except => [:api_index]


  # GET /categories
  # GET /categories.json
  def index
    @categories = @current_user.categories
  end

  def api_index
    authenticate_or_request_with_http_token do |token,options|
      auth_user = User.find_by(token: token)
      if( auth_user != nil )
        @categories = auth_user.categories
        render 'index', formats: 'json', handlers: 'jbuilder'
      end
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = @current_user.categories.build( category_params )
    # @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html {
           flash[:success] = "Category was successfully created."
           redirect_to( categories_url )
        }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html {
           flash[:success] = "Category was successfully updated."
           redirect_to( @category )
        }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html {
        flash[:success] = "Category was successfully destroyed."
        redirect_to( categories_url )
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = current_user.categories.find( params[ :id ] )
      redirect_to( root_url ) if @category.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end

end
