require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup" do
    get users_signup_path
    assert_no_difference 'User.count' do
      post users_signup_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new' # errorが発生したらnewへ戻る
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_select 'form[action="/users/signup"]'
  end

  test "valid signup" do
    get users_signup_path
    assert_difference 'User.count', 1 do
      post users_signup_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect! # リダイレクト先に移る
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
