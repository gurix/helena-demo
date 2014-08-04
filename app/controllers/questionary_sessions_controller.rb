class QuestionarySessionsController < Helena::SessionsController
  def show
    @session = QuestionarySession.find_by view_token: params[:token]
    @version = @session.survey.versions.find(@session.version_id)
    # content = Haml::Engine.new(File.read(Rails.root.join "db/seeds/files/report_satisfaction_scale_survey.en.html.haml")).render
    content = @version.session_report.html_safe if @version.session_report.present?
    respond_to do |format|
      format.html { render html: content, layout: true }
      format.json { render json: @session }
    end
  end

  def new
    survey = Helena::Survey.find params[:survey_id]
    session = QuestionarySession.new survey: survey, version: survey.newest_version, user: current_user
    session.save && redirect_to(helena.edit_session_path(session.token), status: :found)
  end
end
