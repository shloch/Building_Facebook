require 'rails_helper'
RSpec.feature 'Creating a post :', type: :feature do
  before :each do
    @user = FactoryBot.create(:user1)
    visit root_path
    fill_in 'user_login', with: @user.email
    fill_in 'user_password', with: 'password'
    click_button 'Login'
    expect(page).to have_content('Signed in successfully') # Dashboard level
  end

  it 'Should add new post correctly and redirect to same page post form is' do
    visit "/profiles/#{@user.id}"
    present_url = URI.parse(current_url)
    @post = FactoryBot.create(:post1, author_id: @user.id)
    fill_in 'exampleFormControlTextarea1', with: @post.post_text # posting form
    click_on('Submit')
    expect(page).to have_content('Post succesfully created')
    redirected_url = URI.parse(current_url)
    expect(present_url).to eq(redirected_url)
  end

  it 'should send send warning message when posting with wrong/blank data' do
    visit "/profiles/#{@user.id}"
    expect { @post = FactoryBot.create(:invalid_post, author_id: @user.id) }.to raise_error(ActiveRecord::RecordInvalid) # no form found here
    fill_in 'exampleFormControlTextarea1', with: '' # posting form
    click_on('Submit')
    expect(page).to have_content('Post could not be created')
  end
end
