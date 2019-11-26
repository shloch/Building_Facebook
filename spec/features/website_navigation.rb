require 'rails_helper'
RSpec.feature 'Navigation should be succesful between pages', type: :feature do
  before :each do
    # @user = create(:user1)
    @user = FactoryBot.create(:user1)
    visit root_path
    fill_in 'user_login', with: @user.email
    fill_in 'user_password', with: 'password'
    click_button 'Login'
    expect(page).to have_content('Signed in successfully') # Dashboard level
  end

  it 'should have the name of logged user on dashboard(on top and left menu)' do
    expect(page).to have_content(@user.name)
  end

  it 'should go from home page to friendship page successfully' do
    click_link('Friendships')
    expect(page).to have_content('Add new friends')
    find_link('Your Friends').visible?
    find_link('Pending Requests').visible?
  end

  it 'should contain the posting form on dashboard and also after clicking "News Feed" link' do
    find('form#new_post') # find new post form with this ID
    visit '/friendships'
    expect { find('form#new_post') }.to raise_error(Capybara::ElementNotFound) # no form found here
    click_link('News feed')
    find('form#new_post')
  end

  it 'User Profile page should have Post form, gravatar image, user details infos' do
    visit "/profiles/#{@user.id}"
    find('form#new_post')
    within("//div[@class='user-circle']") do
      find('img.gravatar')
    end
    expect(page).to have_content(@user.email)
    expect(page).to have_content(@user.mobile)
    expect(page).to have_content(@user.date_of_birth.strftime('%B %d, %Y'))
  end

  it 'Should display the landing page after i logout' do
    click_link('Logout')
    find('form.new_user') # logging form
    find('form.signUp') # signup form
    expect(page).to have_content('Welcome to FACEBOOK')
    expect(page).to have_content('Create a new account')
  end
end
