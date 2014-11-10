Helena::Session.class_eval do
  belongs_to :user, inverse_of: :sessions

  def as_json(options)
    session = super(options)
    session[:user] = user.as_json
    session[:survey] = survey
    session[:version] = survey.versions.find(version_id)
    session[:answer] = answers_as_hash
    session
  end
end
