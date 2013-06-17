require 'spec_helper'

describe CommentsController do


  context "CREATE action" do
    before :each do
      @post = FactoryGirl.create(:post)
      sign_in @post.user
    end

    it "should create comment" do
      post :create,{:post_id => @post.id, :comment => {:body=>"some comment"}}
      assert_redirected_to (post_path(@post))
      assert_equal 'Comment was successfully created.', flash[:notice]
    end

    it "should not create comment without body" do
      post :create,{:post_id => @post.id, :comment => {:body=>""}}
      assert_redirected_to (post_path(@post))
      assert_equal 'Comment create error.', flash[:alert]
    end
  end

end
