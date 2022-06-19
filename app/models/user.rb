class User < ApplicationRecord
  has_many :twitter_accounts
  has_many :tweets
  has_secure_password

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Must be a valid email address.' }

  def self.from_omniauth(resp)
    u = User.where(uid: resp[:uid], provider: resp[:provider]).first_or_initialize
    password = SecureRandom.hex(16)
    u.update(
      email: resp.info.email,
      uid: resp.uid,
      name: resp.info.name,
      avatar: resp.info.image,
      password: password,
      password_confirmation: password
    )
    u.save!
  end
end
