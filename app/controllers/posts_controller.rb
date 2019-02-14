class PostsController < ApplicationController
  before_action( :set_post, only: [:show, :edit, :update, :destroy] )
  before_action( :signed_in_user, except: [:api_index, :api_show] )
  protect_from_forgery :except => [:api_index, :api_show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = @current_user.posts
  end

  def api_index
    authenticate_or_request_with_http_token do |token,options|
      auth_user = User.find_by(token: token)
      if( auth_user != nil )
        @posts = auth_user.posts
        render 'index', formats: 'json', handlers: 'jbuilder'
      end
    end
  end

  def api_show
    authenticate_or_request_with_http_token do |token,options|
      auth_user = User.find_by(token: token)
      if( auth_user != nil )
        @post = auth_user.posts.find( params[ :id ] )
        render 'show', formats: 'json', handlers: 'jbuilder'
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = @current_user.posts.build( post_params )
    # @post = Post.new( post_params,)

    respond_to do |format|
      if @post.save
        format.html {
          flash[:success] = "Post was successfully created."
          redirect_to( @post )
         }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html {
          flash[:success] = "Post was successfully updated."
          redirect_to( @post )
        }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html {
        flash[:success] = "Post was successfully destroyed."
        redirect_to( posts_url )
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find( params[ :id ] )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit( :title, :body, :published, :category_id, { :tag_ids => [] } )
    end
end
