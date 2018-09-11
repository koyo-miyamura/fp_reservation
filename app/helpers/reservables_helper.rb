module ReservablesHelper

  # DatetimeオブジェクトではなくTimeオブジェクトを入力する
  def is_correct_datetime?(time_obj)

    datetime = time_obj.to_datetime
    minute = datetime.minute # minuteはtimeオブジェクトでは使えない
    unless  minute == 0 || minute == 30
      return false, "予約時間は毎時 00 分 もしくは 30 分としてください"
    end

    if time_obj <= Time.now
      return false, "過去の時間に予約はできません"
    end

    if time_obj.wday == 0
      return false, "日曜は休業日です"
    end    

    y = time_obj.year
    m = time_obj.month
    d = time_obj.day

    is_correct_at_saturday = (Time.new(y, m, d, 11, 00, 00) <= time_obj) && (time_obj < Time.new(y, m, d, 15, 00, 00))
    is_correct_at_weekday  = (Time.new(y, m, d, 10, 00, 00) <= time_obj) && (time_obj < Time.new(y, m, d, 18, 00, 00))
    is_weekday = ([1,2,3,4,5].include?(time_obj.wday))

    if time_obj.saturday? && !is_correct_at_saturday
      return false, "土曜の予約枠は11:00 ~ 15:00です"
    elsif is_weekday && !is_correct_at_weekday
      return false, "平日の予約枠は10:00 ~ 18:00です"
    end

    return true, ""
  end
end
