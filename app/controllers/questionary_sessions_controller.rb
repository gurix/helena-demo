class QuestionarySessionsController < Helena::SessionsController
  before_filter :authenticate_user!

  def show
    @session = current_user.questionary_sessions.find(params[:id])
    version = @survey.versions.find(@session.version_id)
    # content = Haml::Engine.new(File.read(Rails.root.join "db/seeds/files/report_satisfaction_scale_survey.de.html.haml")).render
    content = version.session_report
    template = Liquid::Template.parse(content)
    render html: template.render(variable_mapping.merge user_mapping).html_safe, layout: true
  end

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

  def user_mapping
    { user: @session.user.attributes }.deep_stringify_keys
  end
end
