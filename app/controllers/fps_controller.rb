class FpsController < ApplicationController
  before_action :logged_in_fp, only: [:show, :edit, :update, :destroy]
  before_action :correct_fp,   only: [:show, :edit, :update, :destroy]

  def new
    @fp = Fp.new
  end

  def show
    fp = Fp.find(params[:id])
    @fp_reservable_times = fp.fp_reservable_times.page(params[:reservable_page])
    @fp_reservations     = fp.reservations.page(params[:reservation_page])
  end

  def create
    @fp = Fp.new(fp_params)
    if @fp.save
      log_in_fp @fp
      flash[:success] = "FPの新規登録に成功しました"
      redirect_to @fp
    else
      render 'new'
    end
  end

  def edit
    @fp = Fp.find(params[:id])
  end

  def update
    @fp = Fp.find(params[:id])
    if @fp.update_attributes(fp_params)
      flash[:success] = "更新しました"
      redirect_to @fp
    else
      render 'edit'
    end
  end

  def destroy
    Fp.find(params[:id]).destroy
    flash[:success] = "退会しました"
    redirect_to root_url
  end

  private

    def fp_params
      params.require(:fp).permit(:name, :email, :password,
                                  :password_confirmation)
    end

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
      @fp ||= Fp.find(params[:id])
      unless current_fp?(@fp)
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
