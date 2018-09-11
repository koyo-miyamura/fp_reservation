class ReservationsController < ApplicationController
  before_action :logged_in_user, only: [:new, :index, :destroy]
  before_action :correct_user,   only: [:new, :index, :destroy]

  def index
  end

  def new
  end
  
  private
    # beforeアクション

    # Userのログインを確認する
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
