class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action( :signed_in_user, except: [:api_index] )
  protect_from_forgery :except => [:api_index]

  # GET /tags
  # GET /tags.json
  def index
    @tags = @current_user.tags
  end

  def api_index
    authenticate_or_request_with_http_token do |token,options|
      auth_user = User.find_by(token: token)
      if( auth_user != nil )
        @tags = auth_user.tags
        render 'index', formats: 'json', handlers: 'jbuilder'
      end
    end
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = @current_user.tags.build( tag_params )

    respond_to do |format|
      if @tag.save
        format.html {
          flash[:success] = "Tag was successfully created."
          redirect_to( tags_path )
        }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html {
          flash[:success] = "Tag was successfully updated."
          redirect_to( @tag )
        }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html {
        flash[:success] = "Tag was successfully deleted."
        redirect_to( tags_url )
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = current_user.tags.find( params[ :id ] )
      redirect_to( root_url ) if @tag.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name, :img_url)
    end
end
