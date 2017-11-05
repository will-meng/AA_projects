require 'spec_helper'
require 'rails_helper'

feature 'signing up a user' do
  before(:each) do
    visit new_user_url
    fill_in('Username', with: 'ihateforms')
    fill_in('Password', with: 'ihateforms')
    click_on('Create!')
  end

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content('New User')
  end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content('ihateforms')
    end

    scenario 'redirects to users index page after sign up' do
      expect(page).to have_content('Index Page')
    end
end

feature 'logging in' do

  scenario 'has login page' do
    visit new_session_url
    expect(page).to have_content('Log In')
  end

  feature 'signing in a user' do
    before(:each) do
      visit new_session_url
      fill_in('Username', with: 'ihateforms')
      fill_in('Password', with: 'ihateforms')
      click_on('Log In')
    end

    scenario 'shows username on the homepage after login' do
      expect(page).to have_content('ihateforms')
    end
  end
end



end


feature 'logging out' do

  scenario 'begins with a logged out state' do
    visit users_url
    expect(page).to have_content('Sign In')
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    visit new_user_url
    fill_in('Username', with: 'ihateforms')
    fill_in('Password', with: 'ihateforms')
    click_on('Create!')
    visit new_session_url
    fill_in('Username', with: 'ihateforms')
    fill_in('Password', with: 'ihateforms')
    click_on('Log In')
    visit users_url
    click_on('Log Out')
    expect(page).not_to have_content('ihateforms')
  end

end
