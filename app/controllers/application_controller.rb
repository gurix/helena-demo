class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale, :redirect_to_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def can_administer?
    user_signed_in? # The admin page is available for all user in this demo
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # I18n set default language in url
  def default_url_options(options = {})
    options.merge locale: I18n.locale
  end

  def redirect_to_locale
    redirect_to root_path(locale: I18n.locale) if request.path == '/'
  end

  def after_sign_in_path_for(_resource_or_scope)
    root_path locale: I18n.locale
  end
end
