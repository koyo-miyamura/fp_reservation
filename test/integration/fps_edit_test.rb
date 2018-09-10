require 'test_helper'

class FpsEditTest < ActionDispatch::IntegrationTest

  def setup
    @fp = fps(:fp1)
  end

  test "unsuccessful edit" do
    log_in_fp_as_test(@fp)
    get edit_fp_path(@fp)
    assert_template 'fps/edit'
    patch fp_path(@fp), params: { fp: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_template 'fps/edit'
  end

  test "successful edit" do
    log_in_fp_as_test(@fp)
    get edit_fp_path(@fp)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch fp_path(@fp), params: { fp: { name:  name,
                                              email: email,
                                              password:              "password",
                                              password_confirmation: "password" } }
    assert_redirected_to @fp
    assert_not flash.empty?
    # 小文字で保管されているか確認
    @fp.reload
    assert_equal name,  @fp.name
    assert_equal email, @fp.email
  end

  test "destory from fps edit" do
    log_in_fp_as_test(@fp)
    get edit_fp_path(@fp)
    assert_select "a[href=?]", fp_path(@fp)
    assert_select "a[data-method=delete]"
    assert_difference "Fp.count", -1 do
      delete fp_path(@fp)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
  end
end
