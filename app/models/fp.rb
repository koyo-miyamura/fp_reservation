class Fp < ApplicationRecord
  include Constants
  has_many :reservations,        dependent: :destroy
  has_many :fp_reservable_times, dependent: :destroy
  has_many :reserved_users, through: :reservations, source: :user
  before_save { email.downcase! } # 今回はemailの大文字・小文字を区別しない
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password validations: false # 2重にバリデートするのを防ぐため
  validates :password, presence: true, length: { minimum: 6 }
end
