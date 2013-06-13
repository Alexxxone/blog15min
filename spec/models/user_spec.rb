require 'spec_helper'

describe User do

  it { should have_many (:post )}
  it { should have_many (:comment).as(:commentable).dependent(:destroy) }


 it { should validate_presence_of(:password) }
 it { should validate_uniqueness_of(:email) }



end

=begin

  has_many :posts , :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  attr_accessible :email, :password, :password_confirmation, :remember_me ,:created_at


end





=end