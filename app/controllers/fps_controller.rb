class FpsController < ApplicationController

  def new
    @fp = Fp.new
  end

  def show
    @fp = Fp.find(params[:id])
  end

  def create
    @fp = Fp.new(fp_params)
    if @fp.save
      flash[:success] = "FPの新規登録に成功しました"
      redirect_to @fp
    else
      render 'new'
    end
  end

  private

    def fp_params
      params.require(:fp).permit(:name, :email, :password,
                                  :password_confirmation)
    end
end
