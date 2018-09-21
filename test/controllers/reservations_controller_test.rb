require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user        = users(:user1)
    @other_user  = users(:user2)
    @fp          = fps(:fp1)
    @reservation = reservations(:reservation1)
    @reservable  = fp_reservable_times(:reservable1)
  end

  test "should get new" do
    log_in_user_as_test(@user)
    get new_user_reservation_path(@user)
    assert_response :success
  end
  
  test "should redirect new when not logged in" do
    get new_user_reservation_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect create when not logged in" do
    post user_reservations_path(@user, params: {
                                        reservable_id: @reservable.id,
                                        fp_id: @fp.id })
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Reservation.count' do
      delete user_reservation_path(@user, @reservation)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect new when logged in as wrong user" do
    log_in_user_as_test(@other_user)
    get new_user_reservation_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect create when logged in as wrong user" do
    log_in_user_as_test(@other_user)
    post user_reservations_path(@user, params: {
                                        reservable_id: @reservable.id,
                                        fp_id: @fp.id })
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when logged in as wrong user" do
    log_in_user_as_test(@other_user)
    assert_no_difference 'Reservation.count' do
      delete user_reservation_path(@user, @reservation)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "create" do
    log_in_user_as_test(@user)
    assert_difference 'Reservation.count' do
      post user_reservations_path(@user, params: {
                                          reservable_id: @reservable.id,
                                          fp_id: @fp.id })
    end
    assert_not flash.empty?
    assert_redirected_to new_user_reservation_url
  end

  test "destroy" do
    log_in_user_as_test(@user)
    reservation = @user.reservations.create(fp_id: @fp.id, reserved_on: Time.new(3000, 9, 12, 15, 00, 00)) # 金曜
    assert_difference 'Reservation.count', -1 do
      delete user_reservation_path(@user, reservation)
    end
    reservation = @user.reservations.create(fp_id: @fp.id, reserved_on: Time.new(3000, 9, 12, 15, 30, 00)) # 金曜
    # reservation取り消したら、fp_reservable_timeにカラム追加されるかどうか
    assert_difference 'FpReservableTime.count', 1 do
      delete user_reservation_path(@user, reservation)
    end
    assert_not flash.empty?
    assert_redirected_to user_url(@user)
  end
  
end
