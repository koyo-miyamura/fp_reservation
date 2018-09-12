class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :fp
  default_scope -> { order(reserved_on: :asc) }
  validates :fp_id,       presence: true
  validates :user_id,     presence: true
  validates :reserved_on, presence: true

  def consult_minute
    return 30
  end

  def finish_datetime
    reserved_on + consult_minute.minutes
  end

  # ビュー用。日をまたぐ場合は考慮にいれていない
  def consultation_period
    reserved_on.strftime("%H:%M") + " ~ " + finish_datetime.strftime("%H:%M")
  end
end
