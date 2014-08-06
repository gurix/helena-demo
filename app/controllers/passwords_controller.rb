class PasswordsController < Devise::PasswordsController
  protected

  def after_resetting_password_path_for(_resource)
    root_path I18n.locale
  end
end
