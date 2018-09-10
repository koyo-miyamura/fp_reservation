class FpReservableTime < ApplicationRecord
  belongs_to :fp
  default_scope -> { order(reservable_on: :asc) }
  validates  :fp_id,         presence: true
  validates  :reservable_on, presence: true

  def consult_minute
    return 30
  end

  def finish_datetime
    reservable_on + consult_minute.minutes
  end

  # 日をまたぐ場合は考慮にいれていない
  def consultation_period
    reservable_on.strftime("%H:%M") + " ~ " + finish_datetime.strftime("%H:%M")
  end
end
