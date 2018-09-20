class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to current_user_or_fp
    end
  end
end
