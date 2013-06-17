class CommentsController < ApplicationController


  before_filter :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(params[:comment])
    @comment.post_id=@post.id


    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:alert] = 'Comment create error.'
    end
    redirect_to post_path(@post)
  end
end
