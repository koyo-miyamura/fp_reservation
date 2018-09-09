require 'test_helper'

class FpsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @fp = fps(:fp1)
    @other_fp = fps(:fp2)
  end

  test "should get new" do
    get fps_signup_path
    assert_response :success
  end

  test "should redirect show when not logged in" do
    get fp_path(@fp)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when not logged in" do
    get edit_fp_path(@fp)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
    patch fp_path(@fp), params: { fp: { name: @other_fp.name,
                                              email: @other_fp.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Fp.count' do
      delete fp_path(@fp)
    end
    assert_redirected_to root_url
  end

  test "should redirect show when logged in as wrong fp" do
    log_in_fp_as_test(@other_fp)
    get fp_path(@fp)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when logged in as wrong fp" do
    log_in_fp_as_test(@other_fp)
    get edit_fp_path(@fp)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong fp" do
    log_in_fp_as_test(@other_fp)
    patch fp_path(@fp), params: { fp: { name:  @other_fp.name,
                                              email: @other_fp.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destory when logged in as wrong fp" do
    log_in_fp_as_test(@other_fp)
    assert_no_difference "Fp.count" do
      delete fp_path(@fp)    
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "destory" do
    log_in_fp_as_test(@fp)
    assert_difference "Fp.count", -1 do
      delete fp_path(@fp)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
