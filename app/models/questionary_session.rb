class QuestionarySession < Helena::Session
  belongs_to :user, inverse_of: :questionary_sessions

  def as_json(options)
    session = super(options)
    session[:user] = user.as_json(only: :name)
    session[:survey] = survey
    session[:version] = survey.versions.find(version_id)
    session
  end
end
