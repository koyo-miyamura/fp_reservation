require 'test_helper'

class FpReservableTimesController < ActionDispatch::IntegrationTest

  def setup
    @fp = fps(:fp1)
    log_in_fp_as_test(@fp)
  end

  test "should get new" do
    get reservables_fp_path(@fp)
    assert_response :success
  end
end
