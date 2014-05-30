class WelcomeController < ApplicationController
  def index
    @surveys = Helena::Survey.asc(:created_at).where(language: I18n.locale)
  end
end
