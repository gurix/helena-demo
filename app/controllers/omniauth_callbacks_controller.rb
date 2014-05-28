class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    handle_redirect('devise.twitter_uid', 'Twitter')
  end

  def facebook
    handle_redirect('devise.facebook_data', 'Facebook')
  end

  private

  def handle_redirect(session_variable, kind)
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      session[session_variable] = env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def user
    User.find_for_oauth(env['omniauth.auth'], current_user)
  end
end
