class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def show
    @user_reservations = @user.reservations.page(params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user @user
      flash[:success] = "ユーザの新規登録に成功しました"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "退会しました"
    redirect_to root_url
  end

  private

    def user_params
      params
      .require(:user)
      .permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
    end

    # beforeアクション

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in_user?
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
