class CommentsController < ApplicationController


  before_filter :authenticate_user!

def create
      @post = Post.find(params[:post_id])
      @comment = current_user.comments.new(params[:comment])
      @comment.post_id=@post.id

      respond_to do |format|
        if @comment.save
          format.html { redirect_to :back, notice: 'Comment was successfully created.' }
          format.json { render json: @comment, status: :created, location: @comment }
        else
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
  end
end
