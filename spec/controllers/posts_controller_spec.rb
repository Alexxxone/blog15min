require 'spec_helper'

describe PostsController do

    context "INDEX action" do

          before :each do

            3.times do
              @posts = FactoryGirl.create(:post)
              @posts.tags << FactoryGirl.create(:tag, :name=>"tag_name")
            end
          end

          it "should show posts with tags from params[:tag_name]" do
            puts Post.last.inspect
            puts Tag.last.inspect
            puts PostTag.last.inspect
          end

          it "should create 3" do

           @posts.count.should == 3
          end

          it "should create 3" do
            @post.count.should == 1
          end


        # @posts = Post.joins(:tags).where(:tags => {:name => params[:tag_name]}) if params[:tag_name]

      it do
        get :index
        response.should render_template(:index)

      end



    end #end INDEX action

end #end PostsController
    #
    #context "should create post" do
    #  assert_difference('Post.count') do
    #    post :create, :post => { :title => 'Hi', :body => 'This is my first post.'}
    #  end
    #  assert_redirected_to post_path(assigns(:post))
    #  assert_equal 'Post was successfully created.', flash[:notice]
    #end
    #
    #



#
#    describe "GET #show" do
#
#      it "assigns the requested contact to @contact" do
#        user = FactoryGirl.create :user
#        get :show, :id => user
#        assigns(:user).should eq(user)
#      end
#
#      it "renders the #show view" do
#        get :show, :id => FactoryGirl.create(:user)
#        response.should render_template :show
#      end
#
#    end
#
#    describe "GET #new" do
#
#      it "assigns form params[:user] to the new user" do
#        user = FactoryGirl.create :user
#        get :new
#        assigns(:user).should_not be_nil
#      end
#
#      it "renders the #new view" do
#        get :new, :id => FactoryGirl.create(:user)
#        response.should render_template :new
#      end
#
#    end
#
#    describe "POST #create" do
#
#      context "with valid attributes" do
#
#        it "creates a new user" do
#          expect{
#            post :create, :user => FactoryGirl.attributes_for(:user)
#          }.to change(User,:count).by(1)
#        end
#
#        it "redirects to the new contact" do
#          post :create, user: FactoryGirl.attributes_for(:user)
#          response.should redirect_to users_path
#        end
#
#      end
#
#      context "with invalid attributes" do
#
#        it "does not save the new contact" do
#          expect{
#            post :create, :user => {}
#          }.to_not change(User,:count)
#        end
#
#        it "re-renders the new method" do
#          post :create, :user => FactoryGirl.attributes_for(:invalid_user)
#          response.should render_template :new
#        end
#
#      end
#
#    end
#
#    describe "PUT #update" do
#
#      before :each do
#        @user = FactoryGirl.create :user
#      end
#
#      context "valid attributes" do
#
#        it "located the requested @user" do
#          put :update, :id => @user, :user => FactoryGirl.attributes_for(:user)
#          assigns(:user).should eq(@user)
#        end
#
#        it "changes @user's attributes" do
#          put :update, :id => @user, :user => FactoryGirl.attributes_for(:user, :first_name => "Larry", :last_name => "Smith")
#          @user.reload
#          @user.first_name.should eq("Larry")
#          @user.last_name.should eq("Smith")
#        end
#
#        it "redirects to the users" do
#          put :update, id: @user, contact: FactoryGirl.attributes_for(:user)
#          response.should redirect_to users_path
#        end
#
#      end
#
#      context "invalid attributes" do
#        before :each do
#          @first_name = @user.first_name
#        end
#
#        it "locates the requested @user" do
#          put :update, :id => @user, :user => FactoryGirl.attributes_for(:invalid_user)
#          assigns(:user).should eq(@user)
#        end
#
#        it "changes @user's attributes" do
#          put :update, :id => @user, :user => {:first_name => nil}
#          @user.reload.first_name.should == @first_name
#        end
#
#        it "re-redirect to edit" do
#          put :update, :id => @user, :user => {:first_name => nil, :last_name => nil}
#          response.should render_template :edit
#        end
#
#      end
#
#    end
#
#    describe "DELETE #destroy" do
#
#      before :each do
#        @user = FactoryGirl.create :user
#      end
#
#      it "deletes the user" do
#        expect{
#          delete :destroy, :id => @user
#        }.to change(User,:count).by(-1)
#      end
#
#      it "redirects to users#index" do
#        delete :destroy, :id => @user
#        response.should redirect_to users_url
#      end
#
#    end
#  end
#
#end