require 'spec_helper'
describe Tag do

  it {have_db_column(:name).of_type(:string)}
  it {have_db_column(:created_at).
      of_type(:datetime).
      with_options(:null => false)}
  it {have_db_column(:updated_at).
      of_type(:datetime).
      with_options(:null => false)}


  it { should allow_mass_assignment_of(:name) }
  it { should_not allow_mass_assignment_of(:id) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }


  it { should validate_presence_of(:name) }


  it { should have_many(:post_tags) }
  it { should have_many(:posts).through(:post_tags) }

  it { should accept_nested_attributes_for(:posts) }



  context "should create tag and post" do
    before :each do
    post = FactoryGirl.create(:post)
     3.times do |i|
       post.tags << FactoryGirl.create(:tag)
      end
    end

    it "should create  1 post" do
      Post.count.should == 1
    end
    it "should create 3" do
      Tag.count.should == 3
    end

  end


end

