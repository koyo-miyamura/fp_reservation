class FpReservableTime < ApplicationRecord
  belongs_to :fp

  scope :show_order, -> { order(reservable_on: :asc) }
  
  validates :fp_id,
    presence: true,
    uniqueness: { 
      scope: :reservable_on,
      message: "Already reservable"
    }
  validate :is_correct_reservable_on?

  CONSULT_MINUTE = 30

  def finish_datetime
    reservable_on + CONSULT_MINUTE.minutes
  end

  # 日をまたぐ場合は考慮にいれていない
  def consultation_period
    reservable_on.strftime("%H:%M") + " ~ " + finish_datetime.strftime("%H:%M")
  end
  
  ##### validationメソッド

  # reservable_onはDatetimeオブジェクトではなくTimeオブジェクト
  def is_correct_reservable_on?
    if reservable_on.nil?
      errors.add(:reservable_on, "予約時間を入力してください")
      return
    end

    datetime = reservable_on.to_datetime
    minute   = datetime.minute # minuteはtimeオブジェクトでは使えない
    unless  minute == 0 || minute == 30
      errors.add(:reservable_on, "予約時間は毎時 00 分 もしくは 30 分としてください")
      return
    end
    
    if reservable_on <= Time.now
      errors.add(:reservable_on, "過去の時間に予約はできません")
      return
    end
    
    if reservable_on.wday == 0
      errors.add(:reservable_on, "日曜は休業日です")
      return
    end    
    
    y = reservable_on.year
    m = reservable_on.month
    d = reservable_on.day
    is_correct_at_saturday = (Time.new(y, m, d, 11, 00, 00) <= reservable_on) && (reservable_on < Time.new(y, m, d, 15, 00, 00))
    is_correct_at_weekday  = (Time.new(y, m, d, 10, 00, 00) <= reservable_on) && (reservable_on < Time.new(y, m, d, 18, 00, 00))
    is_weekday = ([1,2,3,4,5].include?(reservable_on.wday))
    
    if reservable_on.saturday? && !is_correct_at_saturday
      errors.add(:reservable_on, "土曜の予約枠は11:00 ~ 15:00です")
      return
    elsif is_weekday && !is_correct_at_weekday
      errors.add(:reservable_on, "平日の予約枠は10:00 ~ 18:00です")
    end
  end

  ##### クラスメソッド

  def self.convert_str_to_time(str_reservable_on)
    begin
      # DatetimeオブジェクトではなくTimeオブジェクトにしないと日本タイムゾーンにならない
      reservable_on = Time.strptime(str_reservable_on, "%Y/%m/%d %H:%M")
    rescue => exception
      return false
    end
    return reservable_on
  end
end
