require 'rails_helper'
RSpec.feature "SigninTests", type: :feature do
  before :each do
    #@user = create(:user1)
    @user = FactoryBot.create(:user1) 
  end
  it 'should sign in' do
    visit root_path
    fill_in 'user_login', with: @user.email
    fill_in 'user_password', with: 'password'
    click_button 'Login'
    expect(page).to have_content('Signed in successfully')
    
  end
end
