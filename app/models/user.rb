class User < ApplicationRecord
  has_many :reservations,  dependent: :destroy
  has_many :reserving_fps, through: :reservations, source: :fp
  before_save { email.downcase! } # 今回はemailの大文字・小文字を区別しない
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password validations: false # 2重にバリデートするのを防ぐため
  validates :password, presence: true, length: { minimum: 6 }
end
