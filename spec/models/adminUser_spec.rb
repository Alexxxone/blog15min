require 'spec_helper'

describe AdminUser do



  it {have_db_column(:id).of_type(:integer)}
  it {have_db_column(:email).of_type(:string)}
  it {have_db_column(:encrypted_password).of_type(:string)}
  it {have_db_column(:reset_password_token).of_type(:string)}
  it {have_db_column(:reset_password_sent_at).of_type(:datetime)}
  it {have_db_column(:remember_created_at).of_type(:datetime)}
  it {have_db_column(:sign_in_count).of_type(:integer)}
  it {have_db_column(:current_sign_in_at).of_type(:datetime)}
  it {have_db_column(:last_sign_in_at).of_type(:datetime)}
  it {have_db_column(:current_sign_in_ip).of_type(:string)}
  it {have_db_column(:last_sign_in_ip).of_type(:string)}
  it {have_db_column(:created_at).
      of_type(:datetime).
      with_options(:null => false)}
  it {have_db_column(:updated_at).
      of_type(:datetime).
      with_options(:null => false)}

  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:remember_me) }

  it { should_not allow_mass_assignment_of(:id) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should have_many(:comments).dependent(:destroy) }


  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }

end
