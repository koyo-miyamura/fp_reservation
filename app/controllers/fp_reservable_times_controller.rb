
class FpReservableTimesController < ApplicationController
  include FpReservableTimesHelper
  before_action :logged_in_fp, only: [:new, :create, :destroy]
  before_action :correct_fp,   only: [:new, :create, :destroy]

  def new
    @fp_reservable_time = FpReservableTime.new
  end

  def create
    str_reservable_on = params["fp_reservable_time"]["reservable_on"]
    unless reservable_on = FpReservableTime.convert_str_to_time(str_reservable_on)
      flash[:danger] = "入力値が不正です"
      redirect_to new_fp_fp_reservable_time_url
      return
    end

    @fp_reservable_time = FpReservableTime.new(fp_id: current_fp.id, reservable_on: reservable_on)
    if @fp_reservable_time.save
      flash[:success] = "予約受付時間を更新しました"
      redirect_to new_fp_fp_reservable_time_url
    else
      render 'new'
    end
  end

  def destroy
    FpReservableTime.find(params[:id]).destroy
    flash[:success] = "予約受付削除しました"
    redirect_to current_fp
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
      @fp ||= Fp.find(params[:fp_id])
      unless current_fp?(@fp)
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
