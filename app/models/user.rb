class User < ActiveRecord::Base
  has_secure_password

  has_many :notes
  has_many :services
  has_many :comments

  # TODO review validates and spec
  validates :username, format: { with: /\A[a-z0-9_]+\z/ }, length: { maximum: 20 }, uniqueness: true, on: :create
  validates :password, length: { minimum: 4, maximum: 20 }, confirmation: true, allow_nil: true
  validates :email, email: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :bio, presence: true, length: { maximum: 400 }, allow_nil: true

  scope :with_reset_token, lambda {|token| where(reset_token: token).where("reset_token_expired_at > ?", Time.now)}

  def image_url
    '/images/user_default.jpg'
  end

  def save_reset_token
    while true
      reset_token = SecureRandom.uuid
      break unless self.class.exists?(reset_token: reset_token)
    end

    self.attributes = { reset_token: reset_token,
                        reset_token_expired_at: 24.hours.since }
    self.save(validate: false)
  end

  def reset_password(password, password_confirmation)
    self.attributes = { password: password,
                        password_confirmation: password_confirmation }
    if self.valid?
      self.attributes = { reset_token: nil,
                          reset_token_expired_at: nil }
      self.save
    else
      return false
    end
  end

  def owner?(model)
    return false unless model.respond_to?(:user_id)

    self.id == model.user_id
  end

  def connected?
    !self.services.blank?
  end

  def service_token
    return nil unless connected?

    self.services.first.token
  end
end
