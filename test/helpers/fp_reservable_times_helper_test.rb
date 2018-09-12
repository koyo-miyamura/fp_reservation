require 'test_helper'

class FpReservableTimesHelperTest < ActionView::TestCase

  test "should be minutes 00 or 30" do
    dt = Time.new(2018, 9, 12, 14, 00, 00) # 水曜
    res, flash = is_correct_datetime?(dt)
    assert res

    dt = Time.new(2018, 9, 12, 14, 30, 00)
    res, flash = is_correct_datetime?(dt)
    assert res

    dt = dt + 1.minutes
    res, flash = is_correct_datetime?(dt)
    assert_not res
  end

  test "should not be past datetime" do
    dt = Time.new(2003, 10, 28, 14, 00, 00) # 火曜
    res, flash = is_correct_datetime?(dt)
    assert_not res
  end

  test "Sunday should not be correct" do
    dt = Time.new(2200, 9, 7, 14, 00, 00) # 日曜
    res, flash = is_correct_datetime?(dt)
    assert_not res
  end

  test "Saturday should be 11:00 ~ 15:00" do
    dt = Time.new(2200, 9, 6, 10, 30, 00) # 土曜
    res, flash = is_correct_datetime?(dt)
    assert_not res
    dt = Time.new(2200, 9, 6, 15, 00, 00) # 土曜
    res, flash = is_correct_datetime?(dt)
    assert_not res
    dt = Time.new(2200, 9, 6, 11, 00, 00)
    res, flash = is_correct_datetime?(dt)
    assert res
    dt = Time.new(2200, 9, 6, 14, 30, 00)
    res, flash = is_correct_datetime?(dt)
    assert res
  end

  test "Weekday should be 10:00 ~ 18:00" do
    dt = Time.new(2200, 9, 5, 9, 30, 00) # 金曜
    res, flash = is_correct_datetime?(dt)
    assert_not res
    dt = Time.new(2200, 9, 5, 18, 00, 00)
    res, flash = is_correct_datetime?(dt)
    assert_not res
    dt = Time.new(2200, 9, 5, 10, 00, 00)
    res, flash = is_correct_datetime?(dt)
    assert res
    dt = Time.new(2200, 9, 5, 17, 30, 00)
    res, flash = is_correct_datetime?(dt)
    assert res
  end
end
