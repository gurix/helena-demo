class QuestionarySessionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_survey

  def new
    session = QuestionarySession.new survey: @survey, version: @survey.newest_version, user: current_user
    if session.save
      redirect_to helena.edit_survey_session_path(@survey, session), status: :found
    else
      flash[:error] = t 'shared.errors.failed_to_create_session'
      redirect_to main_app.root_path
    end
  end

  private

  def load_survey
    @survey = Helena::Survey.find params[:survey_id]
  end
end
