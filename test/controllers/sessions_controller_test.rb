require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "should get users_new" do
    get login_users_path
    assert_response :success
  end

  test "should get fps_new" do
    get login_fps_path
    assert_response :success
  end

end
