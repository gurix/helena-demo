require 'spec_helper'

describe QuestionarySessionsController do
  before do
    @user = create :user
    @user.confirm!
    @survey = create :survey
    @baseversion = @survey.versions.create version: 0
  end

  it 'generates a new session' do
    sign_in @user

    published_version = Helena::VersionPublisher.publish @baseversion
    published_version.notes = 'bla bla'
    published_version.save

    expect { get :new, survey_id: @survey }.to change { QuestionarySession.count }.by(1)
  end
end
