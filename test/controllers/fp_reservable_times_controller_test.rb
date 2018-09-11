require 'test_helper'

class FpReservableTimesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @fp = fps(:fp1)
    log_in_fp_as_test(@fp)
  end

  test "should get new" do
    get new_fp_fp_reservable_time_path(@fp)
    assert_response :success
  end
end
