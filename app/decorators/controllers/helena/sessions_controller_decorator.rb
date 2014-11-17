Helena::SessionsController.class_eval do
  skip_before_action :authenticate_staging, only: :show

  respond_to :html, :json

  def show
    flash.now[:notice] = params[:notice]
    @session = Helena::Session.find_by view_token: params[:token]
    # @content = Slim::Template.new(Rails.root.join("db/seeds/files/report_satisfaction_scale_survey.de.html.slim").to_s).render.html_safe
    @version = @session.survey.versions.find @session.version_id
    @content = session_report
    respond_with @session
  end

  def new
    survey = Helena::Survey.find params[:survey_id]
    session = Helena::Session.new survey: survey, version: survey.newest_version, user: current_user
    session.save && redirect_to(helena.edit_session_path(session.token), status: :found)
  end
end
