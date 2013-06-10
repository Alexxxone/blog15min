ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "a", :id => "a" do

      span :class => "blank_slate" do
        span

      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
     columns do
       column do
         panel "Not checked" do
           ul do
             Post.waiting_to_approve.order("created_at DESC").map do |post|
               li link_to(post.title, edit_admin_post_path(post.id))
             end
           end
         end
       end
       column do
         panel "On verification" do
           ul do
             Post.waiting_warning.order("created_at DESC").map do |post|
               li link_to(post.title, edit_admin_post_path(post.id))
             end
           end
         end
       end
       column do
         panel "Last two users" do
           ul do
             @user = User.order("created_at DESC").limit(2)
             @user.each do |user|
               li link_to(user.email,edit_admin_user_path(user.id))
             end
           end
         end
       end
       column do
         panel "Comments" do
          span link_to "All comments", admin_comments_path
           ul do
             h3 "Last comments"
             @comment = Comment.limit(10).order("created_at DESC")
             @comment.each do |comment|
               li link_to(comment.body,edit_admin_comment_path(comment.id))
             end
           end
           end
         end
       column do
         panel "Answers from users" do
           ul do

             @comments = Comment.where("commentable_type ='User'").limit(10).order("created_at DESC")
             @comments.each do |comment|
               li link_to(comment.body,edit_admin_comment_path(comment.id))
             end
           end
         end
       end






     end

  end # content
end
