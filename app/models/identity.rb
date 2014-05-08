class Identity
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, index: true

  field :uid, type: String
  field :provider, type: String
  field :token, type: String
  field :secret, type: String
  field :expires_at, type: DateTime

  field :email, type: String
  field :image, type: String
  field :nickname, type: String
  field :first_name, type: String
  field :last_name, type: String

  index({ uid: 1, provider: 1 }, { unique: true })
  # rubocop:disable all
  def self.find_from_oauth(auth)
    identity = where(auth.slice(:provider, :uid)).first_or_create do | _identity |
      _identity.provider     = auth.provider
      _identity.uid          = auth.uid
      _identity.token        = auth.credentials.token
      _identity.secret       = auth.credentials.secret if auth.credentials.secret
      _identity.expires_at   = auth.credentials.expires_at if auth.credentials.expires_at
      _identity.email        = auth.info.email if auth.info.email
      _identity.image        = auth.info.image if auth.info.image
      _identity.nickname     = auth.info.nickname
      _identity.first_name   = auth.info.first_name
      _identity.last_name    = auth.info.last_name
    end
    identity.save!

    unless identity.persisted?
      redirect_to root_url, alert: 'Something went wrong, please try again.'
    end
    identity
  end
  # rubocop:enable all
end
