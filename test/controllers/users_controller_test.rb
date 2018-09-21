require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user       = users(:user1)
    @other_user = users(:user2)
  end

  test "should get new" do
    get signup_users_path
    assert_response :success
  end

  test "should redirect show when not logged in" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @other_user.name,
                                              email: @other_user.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "should redirect show when logged in as wrong user" do
    log_in_user_as_test(@other_user)
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_user_as_test(@other_user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_user_as_test(@other_user)
    patch user_path(@user), params: { user: { name:  @other_user.name,
                                              email: @other_user.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destory when logged in as wrong user" do
    log_in_user_as_test(@other_user)
    assert_no_difference "User.count" do
      delete user_path(@user)    
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "destory" do
    log_in_user_as_test(@user)
    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
