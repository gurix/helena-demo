require 'spec_helper'

feature 'Questionary sessions' do
  background do
    @user = sign_in_as_user
    @survey = create :survey
    @baseversion = @survey.versions.create version: 0
  end

  scenario 'generating a new session' do

    published_version = Helena::VersionPublisher.publish @baseversion
    published_version.notes = 'bla bla'
    published_version.session_report = '{{ country }} {{ released }}'
    published_version.save

    session = QuestionarySession.create survey: @survey, version: @survey.newest_version, user: @user
    session.answers << build(:string_answer, code: 'country', value: 'Canada')
    session.answers << build(:integer_answer, code: 'released', value: 2006)

    visit survey_questionary_session_path(:en, @survey, session)

    expect(page).to have_content 'Canada 2006'
  end
end
