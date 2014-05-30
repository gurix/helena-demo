class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale, :set_home_breadcrumb, :redirect_to_locale

  def set_home_breadcrumb
    unless request.path == main_app.root_path(locale: I18n.locale)
      add_breadcrumb t('shared.navigation.home'), main_app.root_path(locale: I18n.locale)
    end
  end

  def can_administer?
    user_signed_in? # The admin page is available for all user in this demo
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def redirect_to_locale
    redirect_to root_path(locale: I18n.locale) if request.path == '/'
  end
end
