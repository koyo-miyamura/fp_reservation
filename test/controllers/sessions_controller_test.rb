require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "should get users_new" do
    get users_login_path
    assert_response :success
  end

  test "should get fps_new" do
    get fps_login_path
    assert_response :success
  end

end
