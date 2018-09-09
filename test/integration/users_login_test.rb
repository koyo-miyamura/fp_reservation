require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user1)
  end

  test "login with invalid information" do
    get users_login_path
    assert_template 'sessions/user_new'
    post users_login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/user_new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get users_login_path
    post users_login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert logged_in_user_as_test?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", users_login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not logged_in_user_as_test?
    assert_redirected_to root_url
    delete logout_path # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレート
    follow_redirect!
    assert_select "a[href=?]", users_login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
