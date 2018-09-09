class SessionsController < ApplicationController

  def user_new
  end

  def user_create
    @user = User.find_by(email: params[:session][:email].downcase) # emailによるユーザ検索
    if @user && @user.authenticate(params[:session][:password])    # ユーザが存在&&パスワードが正しい
      log_in_user @user
      redirect_to @user
    else
      flash.now[:danger] = 'emailとpasswordの組み合わせが不正です'
      render 'user_new'
    end
  end

  def fp_new
  end

  def fp_create
    @fp = Fp.find_by(email: params[:session][:email].downcase) # emailによるユーザ検索
    if @fp && @fp.authenticate(params[:session][:password])    # ユーザが存在&&パスワードが正しい
      log_in_fp @fp
      redirect_to @fp
    else
      flash.now[:danger] = 'emailとpasswordの組み合わせが不正です'
      render 'fp_new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
