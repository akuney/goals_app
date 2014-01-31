class GoalsController < ApplicationController
  before_filter :require_logged_in_user, only: [:new, :index]

  def index
    @user = User.find(params[:user_id])
  end

  def new
  end

  private

  def require_logged_in_user

    unless logged_in?
      flash[:errors] = ["Please sign in first."]
      redirect_to new_session_url
    end
  end

end
