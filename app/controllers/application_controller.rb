class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def can_administer?
    user_signed_in? # The admin page is available for all user in this demo
  end
end
