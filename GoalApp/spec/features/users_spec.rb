# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature 'the signup process', type: :feature do
    before(:each) do
        create(:user)
        visit new_user_url
    end
  scenario 'has a new user page' do
    expect(page).to have_content 'New User'
    expect(page).to have_content 'Sign Up!'
  end
end

feature 'signing up a user', type: :feature do
    before(:each) do
        make_user('goldenfish', 'flowerpower')
    end
    scenario 'shows username on the homepage after signup' do
        expect(page).to have_content "goldenfish"
    end
end

feature 'logging in' , type: :feature do
    before(:each) do
        log_in_user('goldenfish', 'flowerpower')
    end
    scenario 'shows username on the homepage after login' do
        expect(page).to have_content "goldenfish"
    end
end

# feature 'logging out' do
#   scenario 'begins with a logged out state'

#   scenario 'doesn\'t show username on the homepage after logout'

# end