class User
  include Mongoid::Document

  TEMP_EMAIL = 'change@me.com'
  TEMP_EMAIL_REGEX = /change@me.com/

  has_many :identities

  has_many :questionary_sessions

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update
  validates :email, presence: true, unless: Proc.new { |user| user.email == TEMP_EMAIL}


  ## Database authenticatable
  field :email,              type: String, default: ''
  field :name,               type: String, default: ''
  field :encrypted_password, type: String, default: ''

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  ## Token authenticatable
  # field :authentication_token, type: String

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = Identity.find_from_oauth(auth)
    user = identity.user
    if user.nil?
      # Get the existing user from email if the OAuth provider gives us an email
      user = User.where(email: auth.info.email).first if auth.info.email
      # Create the user if it is a new registration
      user = create_user_from_auth(auth) if user.nil?
      # Associate the identity with the user if not already
      identity.update_attribute(:user, user) if identity.user != user
    end
    user
  end

  private

  def self.create_user_from_auth(auth)
    user = User.new(
      name: auth.extra.raw_info.name,
      # username: auth.info.nickname || auth.uid,
      email: auth.info.email.blank? ? TEMP_EMAIL : auth.info.email,
      password: Devise.friendly_token[0, 20]
    )
    user.skip_confirmation!
    user.save!
    user
  end
end
