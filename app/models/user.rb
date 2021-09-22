class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true
  validates :password_confirmation, presence: true
  validates :spotify_id, uniqueness: true
end
