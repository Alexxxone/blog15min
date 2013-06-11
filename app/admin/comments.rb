ActiveAdmin.register Comment do




  index do
    selectable_column
    column :id
    column :body
    default_actions
  end

  member_action :add_comment do
    @post = Post.find(params[:post_id])
    @comment = current_admin_user.comments.new(params[:comment])
    @comment.post_id=@post.id

    respond_to do |format|
      if @comment.save
        format.json { render :json => {:text => 'Comment was successfully created'} }
      else
        format.json { render :json => {:text => 'Error'} }
      end


     end
  end




end
