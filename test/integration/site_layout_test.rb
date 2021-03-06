require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user1)
    @fp   = fps(:fp1)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", signup_fps_path
    assert_select "a[href=?]", signup_users_path
    assert_select "a[href=?]", login_fps_path
    assert_select "a[href=?]", login_users_path
    get signup_users_path
    assert_select "title", full_title('ユーザ登録')
    get login_users_path
    assert_select "title", full_title('ユーザログイン')
    get signup_fps_path
    assert_select "title", full_title('FP登録')
    get login_fps_path
    assert_select "title", full_title('FPログイン')

    log_in_user_as_test(@user)
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", new_user_reservation_path(@user)
    assert_select "a[href=?]", logout_path
    log_in_fp_as_test(@fp)
    follow_redirect!
    assert_template 'fps/show'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", fp_path(@fp)
    assert_select "a[href=?]", edit_fp_path(@fp)
    assert_select "a[href=?]", new_fp_fp_reservable_time_path(@fp)
    assert_select "a[href=?]", logout_path
  end
end
