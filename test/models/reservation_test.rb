require 'test_helper'

class ReservationTest < ActiveSupport::TestCase

  def setup
    @user = users(:user1)
    @fp   = fps(:fp1)
    @reservation = @fp.reservations.build(user_id: @user.id, reserved_on: Time.new(3000, 9, 12, 15, 00, 00)) # 金曜
  end

  test "should be valid" do
    assert @reservation.valid?
  end

  test "should require a fp_id" do
    @reservation.fp_id = nil
    assert_not @reservation.valid?
  end

  test "should require a user_id" do
    @reservation.user_id = nil
    assert_not @reservation.valid?
  end

  test "should require a reserved_on" do
    @reservation.reserved_on = nil
    assert_not @reservation.valid?
  end

  test "should belong to fp" do
    assert_equal @fp, @reservation.fp 
  end

  test "should belong to user" do
    assert_equal @user, @reservation.user
  end

  test "should correct finish datetime" do
      datetime = Time.new(2018, 12, 31, 23, 30, 1).to_datetime
      @reservation.reserved_on = datetime
      datetime_30min_later = Time.new(2019, 1, 1, 0, 0, 1).to_datetime
      assert_equal @reservation.finish_datetime, datetime_30min_later
  end
end
