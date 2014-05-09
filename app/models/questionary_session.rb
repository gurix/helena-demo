class QuestionarySession < Helena::Session
  belongs_to :user, inverse_of: :questionary_sessions
end
