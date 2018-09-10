require 'test_helper'

class ReservationTest < ActiveSupport::TestCase

  def setup
    @user = users(:user1)
    @fp   = fps(:fp1)
    @reservation = @fp.reservations.build(user_id: @user.id, reserved_on: 10.minutes.ago)
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
end
