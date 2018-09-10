class ReservablesController < ApplicationController
  before_action :logged_in_fp, only: [:new, :destroy]
  before_action :correct_fp,   only: [:new, :destroy]

  def new
  end

  private
    # beforeアクション

    # FPのログインを確認する
    def logged_in_fp
      unless logged_in_fp?
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_fp
      @fp = Fp.find(params[:id])
      unless current_fp?(@fp)
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
