class GoalsController < ApplicationController
  before_filter :require_logged_in_user, only: [:new, :index]

  def index
    @user = User.find(params[:user_id])
    @goals = @user.goals

    unless current_user == @user
      @goals.reject!{|goal| goal.hidden == true}
    end
  end

  def new
    @goal = current_user.goals.new
    @user = current_user
  end

  def create
    @goal = current_user.goals.new(params[:goal])
    @user = current_user

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
