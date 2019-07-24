require 'rails_helper'
RSpec.feature "Send and accept friend requests", type: :feature do
  before :each do
    @user = FactoryBot.create(:user1) 
    @user2 = FactoryBot.create(:user2) 
    visit root_path
    fill_in 'user_login', with: @user.email
    fill_in 'user_password', with: 'password'
    click_button 'Login'
    expect(page).to have_content('Signed in successfully')  #Dashboard level
  end

  it '@User can send friend request to @user2' do 
    visit friendships_path
    expect(page).to have_content(@user2.name) #user2's can be seen, so that @user clicks to send request
    expect(page).to have_content('Send Friend Request')
    visit add_friend_friendship_path(@user2)
    expect(page).to have_content('Friend request sent successfully')
 
  end

  it "@user2 can see friend request sent by @user" do 
    #---@user sends friend request to @user2--
    visit add_friend_friendship_path(@user2)
    expect(page).to have_content('Friend request sent successfully')
    click_link('Logout') #@user logs out
    #---@user2 logs in -----------
    fill_in 'user_login', with: @user2.email
    fill_in 'user_password', with: 'password'
    click_button 'Login'
    expect(page).to have_content('Signed in successfully') 
    visit pending_requests_friendships_path
    expect(page).to have_content('The following user(s) sent you a Friend Request') 
    expect(page).to have_content(@user.name) 
    expect(page).to have_content('Accept Friend Request') 
  
  end

  

  it '@User2 accepts request sent by @user and they become valid friends' do 
    #---@user sends friend request to @user2--
    visit add_friend_friendship_path(@user2)
    expect(page).to have_content('Friend request sent successfully')
    click_link('Logout') #@user logs out
    #---@user2 logs in -----------
    fill_in 'user_login', with: @user2.email
    fill_in 'user_password', with: 'password'
    click_button 'Login'
    expect(page).to have_content('Signed in successfully') 
    visit pending_requests_friendships_path
    expect(page).to have_content('Accept Friend Request') 
    click_button 'Accept Friend Request'
    # --- @user2 checks friends list to see @user
    visit your_friends_friendships_path
    expect(page).to have_content(@user.name)
  end




end