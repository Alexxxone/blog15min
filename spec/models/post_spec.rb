require 'spec_helper'

describe Post do

    it { should_not allow_mass_assignment_of(:user_id) }
    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:body) }
    it { FactoryGirl.build(:post).respond_to?( :tags_attributes ).should be_true}

    it { should have_many(:comments).dependent(:destroy)}

    it { should belong_to(:user) }

    it { should have_many(:post_tags) }
    it { should have_many(:tags).through(:post_tags) }

    it { should accept_nested_attributes_for (:tags) }



    context "scopes" do
      before :each do
        3.times do |i|
          FactoryGirl.create(:post, :title => "#post Name #{i}", :confirmed => i)
        end
        FactoryGirl.create(:post, :title => "blabla hidden")
      end

      it "should create 4 posts" do
        Post.count.should == 4
      end


      it "should return correct result for scope not_hidden" do
        Post.not_hidden.count == 3
      end

      it "should return correct result for scope user_confirmed" do
        Post.user_confirmed.count == 1
        Post.user_confirmed.map{|post| post.title}.should ==  ["#post Name 1"]
      end

      it "should return correct result for scope waiting_to_approve" do
        Post.waiting_to_approve.count == 2
        Post.waiting_to_approve.map{|post| post.title}.should == ["#post Name 0", "blabla hidden"]
      end

      it "should return correct result for scope user_confirmed" do
        Post.waiting_warning.count == 1
        Post.waiting_warning.map{|post| post.title}.should ==  ["#post Name 2"]
      end

    end


end