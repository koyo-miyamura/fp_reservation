require 'test_helper'

class FpsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @fp = fps(:fp1)
  end

  test "should get new" do
    get fps_signup_path
    assert_response :success
  end

  test "should get show" do
    get fp_path(@fp)
    assert_response :success
  end

end
