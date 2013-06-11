ActiveAdmin.register Post do
  filter :title

  batch_action :Confirm do |selection|
    @posts=Post.where(:id => selection).update_all("confirmed=1")
    @comments=Comment.where(:post_id => selection).destroy_all
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Confirmed' }
    end
  end

  batch_action :Abort do |selection|
    @posts=Post.where(:id => selection).update_all("confirmed=0")
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Confirmed' }
    end
  end




  index do
    selectable_column
    column :id
    column :title
    column :body
    column "Confirmed ?" do  |post|
      if post.confirmed ==0
        "no"
      elsif post.confirmed ==1
        "yes"
      elsif post.confirmed ==2
        "in progress"
      end
    end
     default_actions
    end

  action_item :only => :edit do
    link_to('Add Tag','javascript:void(0)',onclick:'AddAndRenameAdminInput()')

  end

  action_item :only => :edit do
  link_to('Remove Tag','javascript:void(0)',onclick:'RemoveAdminInput()')
  end


  form do |f|
    f.inputs "Post Details" do
      f.input :title
      f.input :body
    end
    f.inputs "Approved ?" do
      f.input :confirmed, :as => :select ,:collection =>{'No'=>0, 'Yes'=>1,"Write message"=>2}
    end
    f.inputs "Tags" do
      f.fields_for :tags, post.tags.empty? ? Tag.new : post.tags do |tag|
        tag.text_field :name,style:'width:100px;',  class:'tag-name'
      end

    end
    f.actions

  end


end
     # link_to 'Add Tag','javascript:void(0)',onclick:'AddAndRenameAdminInput()'
     # link_to 'Remove Tag','javascript:void(0)',onclick:'RemoveAdminInput()'