require 'spec_helper'

describe QuestionarySessionsController do
  let(:survey) { create :survey }
  let(:baseversion) { survey.versions.create version: 0 }

  it 'generates a new session' do
    published_version = Helena::VersionPublisher.publish baseversion
    published_version.notes = 'bla bla'
    published_version.save

    expect { get :new, survey_id: survey }.to change { QuestionarySession.count }.by(1)
  end

  it 'returns a json result of the current session' do
    version = Helena::VersionPublisher.publish baseversion
    version.save
    session = QuestionarySession.create survey: survey, version: version, answers: [
      build(:string_answer, code: 'string_answer_1', value: 'abc'),
      build(:integer_answer, code: 'integer_answer_1', value: '123')
    ]

    get :show, token: session.view_token, format: :json

    result = ActiveSupport::JSON.decode(response.body)
    expect(result['answer']['string_answer_1']).to eq 'abc'
    expect(result['answer']['integer_answer_1']).to eq 123
  end

  it 'return an html result of the current session' do
    version = Helena::VersionPublisher.publish baseversion
    version.session_report = 'Honeymoonlake'
    version.save

    session = QuestionarySession.create survey: survey, version: version

    get :show, token: session.view_token

    expect(response.body).to render_template(layout: true)
  end
end
