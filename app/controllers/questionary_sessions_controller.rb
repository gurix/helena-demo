class QuestionarySessionsController < Helena::SessionsController
  def show
    @session = QuestionarySession.find_by view_token: params[:token]
    @version = @session.survey.versions.find(@session.version_id)
    # content = Haml::Engine.new(File.read(Rails.root.join "db/seeds/files/report_satisfaction_scale_survey.en.html.haml")).render
    content = @version.session_report
    template = Liquid::Template.parse(content)
    render html: template.render(variable_mapping.merge custom_mapping).html_safe, layout: true
  end

  def new
    survey = Helena::Survey.find params[:survey_id]
    session = QuestionarySession.new survey: survey, version: survey.newest_version, user: current_user
    if session.save
      redirect_to helena.edit_session_path(session.token), status: :found
    else
      flash[:error] = t 'shared.errors.failed_to_create_session'
      redirect_to main_app.root_path
    end
  end

  private

  def custom_mapping
    { user: @session.user.attributes,
      pdf_url: "http://www.html2pdf.it/?url=#{main_app.questionary_session_url(@session.view_token)}&format=A4&margin=1cm"
    }.deep_stringify_keys
  end
end
