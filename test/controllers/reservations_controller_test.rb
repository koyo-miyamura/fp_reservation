require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user1)
    log_in_user_as_test(@user)
  end

  test "should get new" do
    get new_user_reservation_path(@user)
    assert_response :success
  end
end
