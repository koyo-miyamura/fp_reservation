require 'test_helper'

class FpsSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup" do
    get signup_fps_path
    assert_no_difference 'Fp.count' do
      post signup_fps_path, params: { fp: { name:  "",
                                         email: "fp@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'fps/new' # errorが発生したらnewへ戻る
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_select 'form[action="/fps/signup"]'
  end

  test "valid signup" do
    get signup_fps_path
    assert_difference 'Fp.count', 1 do
      post signup_fps_path, params: { fp: { name:  "Example fp",
                                         email: "fp@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect! # リダイレクト先に移る
    assert_template 'fps/show'
    assert_not flash.empty?
  end
end
