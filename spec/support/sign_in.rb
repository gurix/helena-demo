module FeatureSpecsLoginHelper
  # See https://github.com/plataformatec/devise/wiki/How-To%3a-Test-with-Capybara
  include Warden::Test::Helpers
  Warden.test_mode!

  def sign_in_as(user)
    login_as user
    user
  end

  def sign_in_as_user(options = {})
    user = create :user, options
    sign_in_as user
  end
end

RSpec.configure do |config|
  config.include FeatureSpecsLoginHelper, type: :feature
  config.include Devise::TestHelpers, type: :controller
end
