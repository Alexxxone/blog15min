require 'spec_helper'



describe 'POST', :type => :feature, :js=>true do
  include Warden::Test::Helpers



    before :each do
      Warden.test_mode!
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      admin_user = FactoryGirl.create(:admin_user)
      login_as(admin_user, :scope => :admin_user)
    end

    after :each do
      logout(:user)
      logout(:admin_user)
      Warden.test_reset!
    end

  context 'POST CREATION' do

    it "WRONG Post TITLE" do
      visit '/posts'
      page.should have_link('New Post', :href => '/posts/new')
      find(:xpath, "//a[@href='/posts/new']").click
      current_path.should == '/posts/new'
      within("#new_post") do
        fill_in 'post_title', :with=> ''
        fill_in 'post_body', :with=> 'ridght body about big city'*5
        click_button('Create Post')
      end
      current_path.should == '/posts'
      page.should have_content( 'Title is too short (minimum is 10 characters)')
    end


    it "WRONG Post BODY" do
      visit '/posts'
      page.should have_link('New Post', :href => '/posts/new')
      find(:xpath, "//a[@href='/posts/new']").click
      current_path.should == '/posts/new'
      within("#new_post") do
        fill_in 'post_title', :with=> 'right stitle'
        fill_in 'post_body', :with=> 'wrong'
        click_button('Create Post')
      end
      current_path.should == '/posts'
      page.should have_content( 'Body is too short (minimum is 10 characters)')
    end

    it "RIGHT New Post without tags" do
      visit '/posts'
      page.should have_link('New Post', :href => '/posts/new')
      find(:xpath, "//a[@href='/posts/new']").click
      current_path.should == '/posts/new'
      within("#new_post") do
        fill_in 'post_title', :with=> 'right titdfgle'
        fill_in 'post_body', :with=> 'right body about big city'*2
        click_button('Create Post')
      end
      current_path.should == '/posts/1'
    end

    it "RIGHT new Post WITH one Tag" do
      visit '/posts'
      page.should have_link('New Post', :href => '/posts/new')
      find(:xpath, "//a[@href='/posts/new']").click
      current_path.should == '/posts/new'
      within("#new_post") do
        fill_in 'post_title', :with=> 'right tidtle new'
        fill_in 'post_body', :with=> 'right bodys about bigss city'*4
        fill_in 'post_tags_attributes_0_name', :with=> 'city'
        click_button('Create Post')
      end
      current_path.should == '/posts/1'
    end
    it "RIGHT new Post WITH couple Tag" do
      visit '/posts'
        page.should have_link('New Post', :href => '/posts/new')
        find(:xpath, "//a[@href='/posts/new']").click
      current_path.should == '/posts/new'
        within("#new_post") do
          fill_in 'post_title', :with=> 'right newtdditle'
          fill_in 'post_body', :with=> 'right bosdy abousst big city'*2
          fill_in 'post_tags_attributes_0_name', :with=> 'city'
          find(:xpath, "//button[@onclick='add_tag_form()']").click
          fill_in 'post_tags_attributes_1_name', :with=> 'town'
          click_button('Create Post')
        end
      current_path.should == '/posts/1'
        page.should have_content('Warning: 0')
        page.should have_content('Waiting to approve: 1')
        page.should have_link('Admin enter', :href => '/admin/dashboard')
        find(:xpath, "//a[@href='/admin/dashboard']").click
      current_path.should == '/admin/dashboard'
        find(:xpath, "//a[@href='/admin/posts/1/edit']").click
        current_path.should == '/admin/posts/1/edit'
        select('Write message', :from => 'post_confirmed')
        fill_in 'comments_body', :with=> "please change title from 'right newtdditle' to 'new title' "
        find(:xpath, "//a[@onclick='admin_send_comment()']").click
        click_button ('Update Post')
      current_path.should == '/admin/posts/1'
      visit '/posts'
        page.should have_content('Warning: 1')
        page.should have_content('Waiting to approve: 0')
        find(:xpath, "//a[@href='/posts/wait']").click
      current_path.should == '/posts/wait'
        find(:xpath, "//a[@href='/posts/1']", :text =>'Show').click
      current_path.should == '/posts/1'
        page.should have_content("please change title from 'right newtdditle' to 'new title'")
        find(:xpath, "//a[@href='/posts/1/edit']").click
      current_path.should == '/posts/1/edit'
        fill_in 'post_title', :with=> 'new title about big big city'
        click_button('Create Post')
      current_path.should == '/posts/1'
        fill_in 'comment_body', :with=>'i change title'
        click_button ('Add comment')
        page.should have_content ('Comment was successfully created.')
      visit '/admin/'
        find(:xpath, "//a[@href='/admin/posts/1/edit']").click
        current_path.should == '/admin/posts/1/edit'
        select('Yes', :from => 'post_confirmed')
        click_button ('Update Post')
        current_path.should == '/admin/posts/1'
      visit '/posts'
        page.should have_content (' Approved: 1')
        page.should have_content ('Waiting to approve: 0')
        page.should have_content ('Warning: 0')
        page.should have_content ('new title')
        page.should have_content ('right bosdy abousst big city'*2)
        page.should have_content ('city')
        page.should have_content ('town')
        find(:xpath, "//a[@href='/posts/1']", :text =>'Destroy').click
        page.should have_content (' Approved: 0')
        page.should have_content ('Waiting to approve: 0')
        page.should have_content ('Warning: 0')
        page.should_not have_content ('new title')
        page.should_not have_content ('right bosdy abousst big city'*2)
    end
  end

  #
  #context 'Register and back to index' do
  #  it "post_path" do
  #    visit "/posts"
  #    page.should have_link('Sign up', :href => '/users/sign_up')
  #    find(:xpath, "//a[@href='/users/sign_up']").click
  #
  #    within("#new_user") do
  #      fill_in 'user_email', :with=> 'test@mail.ru'
  #      fill_in 'user_password', :with=> '123456'
  #      fill_in 'user_password_confirmation', :with=> '123456'
  #      click_button('Sign up')
  #    end
  #    current_path.should == '/users'
  #  end
  #end

    #context 'Sign out and back to index' do
    #  it "post_path" do
    #    visit('/posts')
    #    page.should have_link('Sign out', :href => '/users/sign_out')
    #    find(:xpath, "//a[@href='/users/sign_out']").click
    #    page.should have_content( 'Signed out successfully.')
    #    current_path.should == '/'
    #  end
    #end





 end


#find(".b-form__select-value").click
#find("#b-form").click

# METHOD GET
#/people?search=name"
#uri = URI.parse(current_url)
#"#{uri.path}?#{uri.query}".should == people_path(:search => 'name')



#visit post_path
#fill_in - текстовое поле через селектор
#select выпадающие списки
#check  check_button
#choose radio_button
#
#within 'element' do
#  check selector
#end
#
#page.should.have.content
#
#
#click button
#click link
#current_page.should be :show
#
#click link