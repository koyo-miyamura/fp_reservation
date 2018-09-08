require 'test_helper'

class FpsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get fps_signup_path
    assert_response :success
  end

end
