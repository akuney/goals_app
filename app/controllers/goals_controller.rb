class GoalsController < ApplicationController
  before_filter :require_logged_in_user, only: [:new, :index]

  def index
    @user = User.includes(:goals).find(params[:user_id])
  end

  def new
    @goal = current_user.goals.new
  end

  def create
    @goal = current_user.goals.new(params[:goal])

    if @goal.save
      redirect_to user_goals_url(@goal.owner)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  private

  def require_logged_in_user
    unless logged_in?
      flash[:errors] = ["Please sign in first."]
      redirect_to new_session_url
    end
  end
end
