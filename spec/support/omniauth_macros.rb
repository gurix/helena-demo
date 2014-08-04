module OmniauthMacros
  # rubocop:disable all
  def mock_auth_for_twitter
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: 123_545,
      info: {
        name: 'mockuser',
        image: 'mock_user_thumbnail_url'
      },
      credentials: {
        token: 'mock_token',
        secret: 'mock_secret'
      },
      extra: {
        raw_info: {
          name: 'mockuser'
        }
      }
    )
  end
  # rubocop:enable all
end
