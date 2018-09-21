require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all
  include ApplicationHelper

  # 定数定義
  User_role_num = 1
  Fp_role_num   = 10
  User_role_num.freeze
  Fp_role_num.freeze
  
  def logged_in_user_as_test?
    !session[:user_id].nil? && session[:role] == User_role_num
  end

  def logged_in_fp_as_test?
    !session[:fp_id].nil? && session[:role] == Fp_role_num
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