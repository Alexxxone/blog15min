class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
      before_filter :authenticate_user!, :only=>[:edit,:new,:destroy,:create,:update,:wait]


  def index
       if params[:tag_name]
            @posts = Post.joins(:tags).where(:tags => {:name => params[:tag_name]})
       else
            @posts =Post.not_hidden.user_confirmed
       end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.not_hidden.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @post.tags.build

    respond_to do |format|
      format.html # new.html.erb
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
    if current_user.posts.length >=3
      respond_to do |format|
        format.html { redirect_to posts_path, alert: 'You cannot create more than 3 unapproved posts' }
     end
    else

      @post = current_user.posts.find_or_create(params[:post])




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
        if current_user.id == @post.user_id  && @post.update_attributes(params[:post])
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { head :no_content }
        else
          format.html {  redirect_to @post, notice: 'ACCESS DENIED' }
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

     @post = current_user.posts.waitingToApprove

  end


end
