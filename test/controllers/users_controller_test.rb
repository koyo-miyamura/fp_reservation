require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:user1)
  end

  test "should get new" do
    get users_signup_path
    assert_response :success
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end

end
