class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :fp
  default_scope -> { order(reserved_on: :asc) }
  validates :fp_id,       presence: true
  validates :user_id,     presence: true
  validates :reserved_on, presence: true
end
