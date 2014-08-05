feature 'Admin area' do
  scenario 'lists survey for administrators' do
    sign_in_as_user

    visit helena.surveys_path

    expect(page).to have_content 'Surveys'
  end
end
