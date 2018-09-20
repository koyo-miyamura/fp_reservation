class FpReservableTime < ApplicationRecord
  belongs_to :fp

  scope :show_order, -> { order(reservable_on: :asc) }
  
  validates  :fp_id,         presence: true
  validates  :reservable_on, presence: true

  CONSULT_MINUTE = 30

  def finish_datetime
    reservable_on + CONSULT_MINUTE.minutes
  end

  # 日をまたぐ場合は考慮にいれていない
  def consultation_period
    reservable_on.strftime("%H:%M") + " ~ " + finish_datetime.strftime("%H:%M")
  end
end
