require 'rails_helper'
RSpec.feature "SignUpTests", type: :feature do
  before :each do
    #@user = create(:user1)
    #@user = FactoryBot.create(:user1) 
  end

  context "Creating a new account for new user : " do
    it 'should sign in' do
        visit root_path
        expect(page).to have_content('Welcome to FACEBOOK')
        expect(page).to have_content('Create a new account')
        find('form.signUp') #signup form
        fill_in 'inputEmail4', with: "test@test.org"
        fill_in 'username', with: 'test_username'
        fill_in 'user_mobile', with: '222-222-222'
        fill_in 'inputPassword', with: 'test_password'
        fill_in 'inputPassword2', with: 'test_password'
        fill_in 'example-date-input', with: '2000-10-24'
        choose('user_gender_idm_valuem')

        click_button 'Sign up'
        expect(page).to have_content('Welcome! You have signed up successfully')
        
    end
  end


  context "Creating a new account with wrong data : " do
    it 'should sign in' do
        visit root_path
        expect(page).to have_content('Welcome to FACEBOOK')
        expect(page).to have_content('Create a new account')
        find('form.signUp') #signup form
        fill_in 'inputEmail4', with: ""
        fill_in 'username', with: ''
        fill_in 'user_mobile', with: ''
        fill_in 'inputPassword', with: ''
        fill_in 'inputPassword2', with: ''
        fill_in 'example-date-input', with: ''
        choose('user_gender_idm_valuem')

        click_button 'Sign up'
        expect(page).to have_content('Mobile can\'t be blank')
        expect(page).to have_content('Mobile is too short (minimum is 6 characters)')
        expect(page).to have_content('Email can\'t be blank')
        expect(page).to have_content('Password can\'t be blank')
        
        
    end
  end
end
