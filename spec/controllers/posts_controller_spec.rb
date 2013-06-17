require 'spec_helper'

describe PostsController do


    context "INDEX action" do

          before :each do
            3.times do
              @posts = FactoryGirl.create(:post)
              @posts.tags << FactoryGirl.create(:tag, :name=>"tag_name")
            end
            @posts = FactoryGirl.create(:post)
            @posts = FactoryGirl.create(:post)
            @posts.tags << FactoryGirl.create(:tag, :name=>"another_tag")
          end

          it "all message index" do
            get :index
            Post.count.should == 6
            response.should render_template(:index)
            expect(response).to be_success
            expect(response.status).to eq(200)
          end


          it "show posts with tag = 'tag_name' " do
            posts_with_tags =  Post.joins(:tags).where(:tags => {:name => 'tag_name'})
            get :index, :tag_name=> 'tag_name'
            expect (posts_with_tags.count.should == 3 )
            response.should render_template(:index)
            expect(assigns(:posts)).to eq(posts_with_tags)
          end



          it "posts with wrong tags" do
            get :index, :tag_name=> 'WRONG_name'
            posts_with_tags =  Post.joins(:tags).where(:tags => {:name => 'WRONG_name'})
            expect (posts_with_tags.count.should == 0 )
            response.should render_template(:index)
          end




    end #end INDEX action

    context "SHOW action" do

      before :each do
        3.times do
          @posts = FactoryGirl.create(:post)
          @posts.tags << FactoryGirl.create(:tag, :name=>"tag_name")
        end
        @posts = FactoryGirl.create(:post)
        @posts = FactoryGirl.create(:post)
        @posts.tags << FactoryGirl.create(:tag, :name=>"another_tag")
      end

      it "show message with index = NUMBER" do
       post =  Post.last
         get :show, :id => post.id

       #  post = Post.find(:id)   - это происходит в конртоллере
       assigns(:post).should eq(post)
         response.should render_template(:show)
      end


    end  #end SHOW action


    context "NEW action" do

       it "NEW with logged in user" do
         sign_in FactoryGirl.create(:user)
         post = Post.new
         post.tags.build
         get :new
         response.should render_template(:new)
       end

       it "NEW without logged user" do
         get :new
         response.should redirect_to(new_user_session_path)
       end

    end  #end NEW action


    context "EDIT action" do

      it "EDIT with logged user" do
        sign_in FactoryGirl.create(:user)
        post = FactoryGirl.create(:post)
        get :edit, :id => post
        assigns(:post).should eq(post)
        response.should render_template(:edit)
      end

      it "EDIT with NOT logged user" do
        post = FactoryGirl.create(:post)
        get :edit, :id => post
        assigns(:post).should eq(post)
        response.should redirect_to(new_user_session_path)
      end

    end #end EDIT action


    context "CREATE action" do

      it "create with logged user" do
        sign_in FactoryGirl.create(:user)
        post :create,  :post => { :title => 'Hi', :body => 'This is my first post.'}
        assert_redirected_to post_path(assigns(:post))
        assert_equal 'Post was successfully created', flash[:notice]
      end

      it "create with NOT logged user" do
        post :create,  :post => { :title => 'Hi', :body => 'This is my first post.'}
        response.should redirect_to(new_user_session_path)
      end

      it "create with logged user more than 3 not approved messages" do
        sign_in FactoryGirl.create(:user)
        4.times do
          post :create,  :post => { :title => 'Hi', :body => 'This is my first post.'}
        end
        assert_redirected_to posts_path
        assert_equal 'You cannot create more than 3 unapproved posts', flash[:alert]
      end

    end #end CREATE action

    context "UPDATE action" do

      it "as" do
        post = FactoryGirl.create(:post)
        sign_in post.user
        put :update, :id => post.id ,:post => {:title=>'NEW TITLE',:body=>'new body'}
        assert_redirected_to post_path(post)
        assert_equal 'Post was successfully updated.', flash[:notice]
      end

      it "update with NOT logged user" do
        post = FactoryGirl.create(:post)
        put :update, :id => post ,:post => {:title=>'NEW TITLE',:body=>'new body'}
        assert_redirected_to post_path(post)
        response.should redirect_to(new_user_session_path)
      end

      it "update with empty fields" do
        post = FactoryGirl.create(:post)
        sign_in post.user
        put :update, :id => post ,:post => {:title=>'',:body=>''}
        assert_redirected_to post_path(post)
        assert_equal 'Fill all inputs', flash[:notice]
      end

    end  #end UPDATE action

      context "DESTROY action" do

        it "delete and Json answer" do
          post = FactoryGirl.create(:post)
          sign_in post.user
          delete :destroy, :id => post
          response.body.should == post.to_json
        end

      end

      context "WAIT action" do

        it "wait" do
         user = FactoryGirl.create(:user)
         sign_in user
         3.times do
           FactoryGirl.create(:post, :user => user)
         end
          FactoryGirl.create(:post_confirmed, :user => user)
          get :wait
          controller.instance_variable_get(:@posts).count.should == 3
          response.should render_template(:wait)
        end

      end

   context "Count action" do

     it "count" do
     user = FactoryGirl.create(:user)
     sign_in user
     FactoryGirl.create(:post, :user => user)      #approved  =0
     2.times do
       FactoryGirl.create(:post_confirmed, :user => user)    #approved  =1
     end
     3.times do
       FactoryGirl.create(:post_warning, :user => user)  #approved  =2
     end

     get :count


     controller.instance_variable_get(:@count_wait).should == 1
     controller.instance_variable_get(:@count_approved).should == 2
     controller.instance_variable_get(:@count_warning).should == 3
     response.body.should ==   controller.instance_variable_get(:@count_wait).to_json
     response.body.should ==   controller.instance_variable_get(:@count_approved).to_json
     response.body.should ==   controller.instance_variable_get(:@count_warning).to_json

     end

   end

end #end PostsController
