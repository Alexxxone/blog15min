# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  post_id          :integer
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :integer
#  commentable_type :string(255)
#

require 'spec_helper'

describe Comment do
  describe 'validations' do

    it {have_db_column(:post_id).of_type(:integer)}
    it {have_db_column(:body).of_type(:text)}
    it {have_db_column(:created_at).
      of_type(:datetime).
      with_options(:null => false)}
    it {have_db_column(:updated_at).
      of_type(:datetime).
      with_options(:null => false)}
    it {have_db_column(:commentable_id).of_type(:integer) }
    it {have_db_column(:commentable_type).of_type(:string)}

    it { should allow_mass_assignment_of(:body) }
    it { should allow_mass_assignment_of(:commentable_type) }
    it { should allow_mass_assignment_of(:commentable_id) }
    it { should_not allow_mass_assignment_of(:id) }
    it { should_not allow_mass_assignment_of(:created_at) }
    it { should_not allow_mass_assignment_of(:updated_at) }

    it { should belong_to(:commentable) }
    it { should belong_to(:post) }

    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:commentable_type) }
    it { should validate_presence_of(:commentable_id) }




  end

end
