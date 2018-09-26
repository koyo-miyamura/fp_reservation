class Reservation < ApplicationRecord
  include ModelConstants

  belongs_to :user
  belongs_to :fp

  scope :show_order, -> { order(reserved_on: :asc) }

  validates :fp_id,       presence: true
  validates :user_id,     presence: true
  validates :reserved_on, presence: true

  def finish_datetime
    reserved_on + CONSULTING_DURATION
  end

  # ビュー用。日をまたぐ場合は考慮にいれていない
  def consultation_period
    reserved_on.strftime("%H:%M") + " ~ " + finish_datetime.strftime("%H:%M")
  end
end
