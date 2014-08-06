require 'spec_helper'

feature 'Authentication' do
  scenario 'A guest signs in' do
    create :user, email: 'hans.muster@somedomain.tld', password: 'Columbo'

    visit main_app.user_session_path

    fill_in 'Email', with: 'hans.muster@somedomain.tld'
    fill_in 'Password', with: 'Columbo'

    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'A guest signs up' do
    visit main_app.new_user_registration_path

    fill_in 'Email', with: 'hans.muster@somedomain.tld'
    fill_in 'Name', with: 'Inspector Columbo'
    fill_in 'Password', with: 'Peugeot403'
    fill_in 'Password confirmation', with: 'Peugeot403'

    click_button 'Register'

    expect(page).to have_content 'You have signed up successfully'
  end

  scenario 'A guest signs in via Twitter' do
    mock_auth_for_twitter
    visit main_app.user_session_path

    click_link 'Sign in with Twitter'

    expect(page).to have_content('mockuser')
  end

  scenario 'A guest signs in via Facebook' do
    mock_auth_for_facebook
    visit main_app.user_session_path

    click_link 'Sign in with Facebook'

    expect(page).to have_content('mockuser')
  end

  scenario 'A guest signs in via Twitter with invalid credentials' do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    visit main_app.user_session_path

    click_link 'Sign in with Twitter'

    expect(page).to have_content('Invalid credentials')
  end

  scenario 'A guest signs in via Facebook with invalid credentials' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit main_app.user_session_path

    click_link 'Sign in with Facebook'

    expect(page).to have_content('Invalid credentials')
  end

  scenario 'A user signs out' do
    sign_in_as_user

    visit main_app.root_path

    click_link 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
