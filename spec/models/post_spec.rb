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



end