class ReservationsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: [:new, :create, :destroy]

  def new
    @fps = Fp.all.includes(:fp_reservable_times).page(params[:id]) # N+1対策
  end

  def create
    reserved_on = FpReservableTime.find(params[:reservable_id]).reservable_on
    FpReservableTime.find(params[:reservable_id]).destroy
    reservation = Reservation.new(fp_id:       params[:fp_id],
                                  user_id:     params[:user_id],
                                  reserved_on: reserved_on)
    if reservation.save
      flash[:success] = "予約完了しました"
      redirect_to new_user_reservation_path
    else
      render 'new'
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    FpReservableTime.create(
      fp_id:         reservation.fp.id,
      reservable_on: reservation.reserved_on)
    reservation.destroy
    flash[:success] = "予約削除しました"
    redirect_to @user
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
      @user ||= User.find(params[:user_id])
      unless current_user?(@user)
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
