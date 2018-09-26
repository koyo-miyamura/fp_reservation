require 'test_helper'

class FpsLoginTest < ActionDispatch::IntegrationTest

  def setup
    @fp = fps(:fp1)
  end

  test "login with invalid information" do
    get login_fps_path
    assert_template 'sessions/fp_new'
    post login_fps_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/fp_new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_fps_path
    post login_fps_path, params: { session: { email:    @fp.email,
                                          password: 'password' } }
    assert logged_in_fp_as_test?
    assert_redirected_to @fp
    follow_redirect!
    assert_template 'fps/show'
    assert_select "a[href=?]", login_fps_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", fp_path(@fp)
    delete logout_path
    assert_not logged_in_fp_as_test?
    assert_redirected_to root_url
    delete logout_path # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレート
    follow_redirect!
    assert_select "a[href=?]", login_fps_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", fp_path(@fp), count: 0
  end
end
