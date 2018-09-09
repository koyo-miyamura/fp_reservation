require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all
  include ApplicationHelper

end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  def log_in_user_as_test(user, password: 'password')
    # テストでは直接セッション扱えないのでpostする
    post users_login_path, params: { session: { email:    user.email,
                                                password: password} }
  end

  # テストFPとしてログインする
  def log_in_fp_as_test(fp, password: 'password')
    post fps_login_path, params: { session: { email:    fp.email,
                                              password: password} }
  end
end