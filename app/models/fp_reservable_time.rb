class FpReservableTime < ApplicationRecord
  belongs_to :fp
  default_scope -> { order(reservable_on: :asc) }
  validates  :fp_id,         presence: true
  validates  :reservable_on, presence: true
end
