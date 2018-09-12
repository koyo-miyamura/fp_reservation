require 'test_helper'

class FpReservableTimesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @fp       = fps(:fp1)
    @other_fp = fps(:fp2)
    @reservable = fp_reservable_times(:reservable1)
  end

  test "should get new" do
    log_in_fp_as_test(@fp)
    get new_fp_fp_reservable_time_path(@fp)
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_fp_fp_reservable_time_path(@fp)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect create when not logged in" do
    post fp_fp_reservable_times_path(@fp)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'FpReservableTime.count' do
      delete fp_fp_reservable_time_path(@fp, @reservable)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect new logged in as wrong fp" do
    log_in_fp_as_test(@other_fp)
    get new_fp_fp_reservable_time_path(@fp)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect create logged in as wrong fp" do
    log_in_fp_as_test(@other_fp)
    post fp_fp_reservable_times_path(@fp), params: { 
      fp_reservable_time: { reservable_on: "3000/10/28 14:00:00"} } 
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy logged in as wrong fp" do
    log_in_fp_as_test(@other_fp)
    assert_no_difference 'FpReservableTime.count' do
      delete fp_fp_reservable_time_path(@fp, @reservable)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "create" do
    log_in_fp_as_test(@fp)
    assert_difference 'FpReservableTime.count' do
      post fp_fp_reservable_times_path(@fp), params: { 
      fp_reservable_time: { reservable_on: "3000/10/28 14:00:00"} } # 平日
    end
    assert_not flash.empty?
    assert_redirected_to new_fp_fp_reservable_time_url
  end

  test "destroy" do
    log_in_fp_as_test(@fp)
    assert_difference 'FpReservableTime.count', -1 do
      delete fp_fp_reservable_time_path(@fp, @reservable)
    end
    assert_not flash.empty?
    assert_redirected_to fp_url(@fp)
  end
end
