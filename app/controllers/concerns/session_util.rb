module SessionUtil
  extend ActiveSupport::Concern

  included do
    helper_method :current_user_or_fp, :current_user, :current_fp,
                  :logged_in?, :logged_in_user?, :logged_in_fp?

    # 定数定義
    USER_ROLE_NUM = 1
    FP_ROLE_NUM   = 10
    USER_ROLE_NUM.freeze
    FP_ROLE_NUM.freeze

    # ユーザログイン
    def log_in_user(user)
      # ユーザとFP両方ログインできない仕様
      session.delete(:fp_id) 
      @current_fp       = nil

      session[:user_id] = user.id
      session[:role]    = USER_ROLE_NUM
    end

    # FPログイン
    def log_in_fp(fp)
      # ユーザとFP両方ログインできない仕様
      session.delete(:user_id)
      @current_user   = nil

      session[:fp_id] = fp.id
      session[:role]  = FP_ROLE_NUM
    end

    # 現在ログイン中のユーザを返す (いる場合)
    def current_user_or_fp
      current_user || current_fp 
    end

    # 現在ログイン中のユーザを返す (いる場合)
    def current_user
      if session[:user_id] && session[:role] == USER_ROLE_NUM
        @current_user ||= User.find_by(id: session[:user_id]) # 2回目以降のクエリを防ぐ
      end
    end

    # 現在ログイン中のFPを返す (いる場合)
    def current_fp
      if session[:fp_id] && session[:role] == FP_ROLE_NUM
        @current_fp ||= Fp.find_by(id: session[:fp_id]) # 2回目以降のクエリを防ぐ
      end
    end

    # 渡されたユーザがログイン済みであればtrueを返す
    def current_user?(user)
      user == current_user
    end

    # 渡されたFPがログイン済みであればtrueを返す
    def current_fp?(fp)
      fp == current_fp
    end

    # ログインしていればtrue、その他ならfalseを返す
    def logged_in?
      logged_in_user? || logged_in_fp?
    end

    # ユーザがログインしていればtrue、その他ならfalseを返す
    def logged_in_user?
      !current_user.nil?
    end

    # FPがログインしていればtrue、その他ならfalseを返す
    def logged_in_fp?
      !current_fp.nil?
    end

    # ログアウトする
    def log_out
      session.delete(:user_id)
      session.delete(:fp_id)
      session.delete(:role)
      @current_user = nil
      @current_fp   = nil
    end
  end
end
