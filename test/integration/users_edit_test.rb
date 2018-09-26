require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user1)
  end

  test "unsuccessful edit" do
    log_in_user_as_test(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_user_as_test(@user)
    get edit_user_path(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_redirected_to @user
    assert_not flash.empty?
    # 小文字で保管されているか確認
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

  test "destory from users edit" do
    log_in_user_as_test(@user)
    get edit_user_path(@user)
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[data-method=delete]"
    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
  end
end
