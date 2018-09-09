require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:user1)
    @fp   = fps(:fp1)
  end

  test "work well when not user login" do
    assert_not current_user?(@user)
    assert_not_equal @user, current_user
    assert_not_equal @user, current
    assert_not logged_in_user?
    assert_not logged_in?
  end

  test "work well when user login" do
    log_in_user(@user)
    assert current_user?(@user)
    assert_equal @user, current_user
    assert_equal @user, current
    assert_not_equal @user, current_fp
    assert logged_in_user?
    assert logged_in?
  end

  test "work well when not fp login" do
    assert_not current_fp?(@fp)
    assert_not_equal @fp, current_fp
    assert_not_equal @fp, current
    assert_not logged_in_fp?
    assert_not logged_in?
  end

  test "work well when fp login" do
    log_in_fp(@fp)
    assert current_fp?(@fp)
    assert_equal @fp, current_fp
    assert_equal @fp, current
    assert_not_equal @fp, current_user
    assert logged_in_fp?
    assert logged_in?
  end

  test "session delete when other role login" do
    log_in_user(@user)
    log_in_fp(@fp)
    assert_not session[:user_id]
    assert_not current_user
    log_in_user(@user)
    assert_not session[:fp_id]
    assert_not current_fp
  end

  test "log_out method" do
    log_out # 未ログイン時にログアウトしてエラー出ないかチェック
    log_in_user(@user)
    log_out
    assert_not session[:user_id]
    assert_not session[:fp_id]
    assert_not session[:role]
    assert_not current_user
    assert_not current_fp
    log_in_fp(@fp)
    log_out
    assert_not session[:user_id]
    assert_not session[:fp_id]
    assert_not session[:role]
    assert_not current_user
    assert_not current_fp
  end
end
