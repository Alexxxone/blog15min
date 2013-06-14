class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  before_filter :init_tags, :init_posts
  before_filter :authenticate_user!, :only => [:edit, :new, :destroy, :create, :update, :wait]


  def index
     @posts = Post.joins(:tags).where(:tags => {:name => params[:tag_name]}) if params[:tag_name]
     respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post= Post.not_hidden.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @post.tags.build

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    if current_user.posts.waiting_to_approve.length >=3
      respond_to do |format|
        format.html { redirect_to posts_path, alert: 'You cannot create more than 3 unapproved posts' }
      end
    else

      @post = current_user.posts.create(params[:post])

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created' }
          format.json { render json: @post, status: :created, location: @post }
        else
          format.html { render action: "new" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])


    respond_to do |format|
      if current_user.id == @post.user_id && @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @post, notice: 'ACCESS DENIED' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end

    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end

  def wait
    @posts = current_user.posts.where("confirmed =2 OR confirmed=0")
  end


  #my methods

  def count
    count_wait=current_user.posts.waiting_to_approve.count
    count_approved=current_user.posts.user_confirmed.count
    count_warning=current_user.posts.waiting_warning.count
    respond_to do |format|
      format.json { render :json => {:countwait => count_wait, :countapproved => count_approved, :countwarning => count_warning } }
    end

  end

  private
  def init_tags
    @tags ||= Tag.all
  end

  private
  def init_posts
    @posts ||= Post.not_hidden.user_confirmed
  end

end
