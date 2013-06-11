class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json

  # GET /comments/1
  # GET /comments/1.json
  def show
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @comment }
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    if !current_user.nil?
      @post = Post.find(params[:post_id])
      @comment = current_user.comments.new(params[:comment])
      @comment.post_id=@post.id

      respond_to do |format|
        if @comment.save
          format.html { redirect_to :back, notice: 'Comment was successfully created.' }
          format.json { render json: @comment, status: :created, location: @comment }
        else
          format.html { render action: "new" }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: 'Only registered users can left comments' }
      end
    end




  end
end
