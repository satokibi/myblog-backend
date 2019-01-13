class User < ApplicationRecord
  has_secure_password
  validates( :mail, presence: true, uniqueness: true )

  def remember( remember_token )
    update_attribute( :remember_token, User.encrypt( remember_token ) )
  end

  def forget
    update_attribute( :remember_token, nil )
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end

end
