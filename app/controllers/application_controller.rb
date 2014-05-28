class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_home_breadcrumb

  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_home_breadcrumb
    add_breadcrumb t('shared.navigation.home'), main_app.root_path unless request.path == main_app.root_path
  end

  def can_administer?
    user_signed_in? # The admin page is available for all user in this demo
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
