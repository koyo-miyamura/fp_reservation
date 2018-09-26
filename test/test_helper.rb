require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all
  include ApplicationHelper

  # 定数定義
  USER_ROLE_NUM = 1
  FP_ROLE_NUM   = 10
  USER_ROLE_NUM.freeze
  FP_ROLE_NUM.freeze

  def logged_in_user_as_test?
    !session[:user_id].nil? && session[:role] == USER_ROLE_NUM
  end

  def logged_in_fp_as_test?
    !session[:fp_id].nil? && session[:role] == FP_ROLE_NUM
  end
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  def log_in_user_as_test(user, password: 'password')
    # テストでは直接セッション扱えないのでpostする
    post login_users_path, params: { session: { email:    user.email,
                                                password: password} }
  end

  # テストFPとしてログインする
  def log_in_fp_as_test(fp, password: 'password')
    post login_fps_path, params: { session: { email:    fp.email,
                                              password: password} }
  end
end