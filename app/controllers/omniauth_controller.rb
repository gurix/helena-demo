class OmniauthController < ApplicationController
  def localized
    session[:omniauth_login_locale] = I18n.locale
    case params[:provider]
    when 'twitter'
      redirect_to user_twitter_omniauth_authorize_path
    when 'facebook'
      redirect_to user_facebook_omniauth_authorize_path
    end
  end
end
