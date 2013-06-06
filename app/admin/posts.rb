ActiveAdmin.register Post do
  filter :title

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
      f.check_box :confirmed,style:'margin-left:20px;'
    end
    f.inputs "Tags" do
      f.fields_for :tags, post.tags.empty? ? Tag.new : post.tags do |tag|
        tag.text_field :name,style:'width:100px;',  class:'tag-name'
      end

    end
    f.actions

  end



end
