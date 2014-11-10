require 'spec_helper'

feature 'Admin area' do
  scenario 'lists survey for administrators' do
    sign_in_as_user

    visit helena_administration.surveys_path

    expect(page).to have_content 'Surveys'
  end
end
