require 'test_helper'

class FpReservableTimeTest < ActiveSupport::TestCase
  def setup
    @fp   = fps(:fp1)
    @fp_reservable_times = @fp.fp_reservable_times.build(
                    reservable_on: Time.new(3000, 9, 12, 15, 00, 00)) # 金曜
    # テスト用メソッド
    def test_valid_reservable_on(y, mon, d, h, min, s)
      dt = Time.new(y, mon, d, h, min, s)
      assert @fp_reservable_times.update_attributes(reservable_on: dt)
    end

    def test_invalid_reservable_on(y, mon, d, h, min, s)
      dt = Time.new(y, mon, d, h, min, s)
      assert_not @fp_reservable_times.update_attributes(reservable_on: dt)
    end
  end

  test "should be valid" do
    assert @fp_reservable_times.valid?
  end

  test "should require a fp_id" do
    @fp_reservable_times.fp_id = nil
    assert_not @fp_reservable_times.valid?
  end

  test "should require a reservable_on" do
    @fp_reservable_times.reservable_on = nil
    assert_not @fp_reservable_times.valid?
  end

  test "should belong to fp" do
    assert_equal @fp, @fp_reservable_times.fp 
  end

  test "should be minutes 00 or 30" do
    test_valid_reservable_on(3000, 9, 12, 14, 00, 00) # 金曜
    test_valid_reservable_on(3000, 9, 12, 14, 30, 00)

    test_invalid_reservable_on(3000, 9, 12, 14, 31, 00)
  end

  test "should not be past datetime" do
    test_invalid_reservable_on(2003, 10, 28, 14, 00, 00)
  end

  test "Sunday should not be correct" do
    test_invalid_reservable_on(2200, 9, 7, 14, 00, 00) # 日曜
  end

  test "Saturday should be 11:00 ~ 15:00" do
    test_invalid_reservable_on(2200, 9, 6, 10, 30, 00) # 土曜  
    test_invalid_reservable_on(2200, 9, 6, 15, 00, 00)
    test_valid_reservable_on(2200, 9, 6, 11, 00, 00)
    test_valid_reservable_on(2200, 9, 6, 14, 30, 00)
  end

  test "Weekdays should be 10:00 ~ 18:00" do
    test_invalid_reservable_on(2200, 9, 5, 9, 30, 00) # 金曜
    test_invalid_reservable_on(2200, 9, 5, 18, 00, 00)
    test_valid_reservable_on(2200, 9, 5, 10, 00, 00)
    test_valid_reservable_on(2200, 9, 5, 17, 30, 00)
  end
end
