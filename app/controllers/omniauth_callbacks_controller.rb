class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    handle_redirect('devise.twitter_uid', 'Twitter')
  end

  def facebook
    handle_redirect('devise.facebook_data', 'Facebook')
  end

  private

  def handle_redirect(session_variable, kind)
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
  end

  def user
    User.find_for_oauth(env['omniauth.auth'], current_user)
  end
end
