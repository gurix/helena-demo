class WelcomeController < ApplicationController
  def index
    @surveys = Helena::Survey.asc(:created_at).all
  end
end
