class GoalsController < ApplicationController
  before_action :require_login

  def new
  end

  def create
    goal = Goal.new(goal_params)
    goal.user_id = current_user.id
    if goal.save
      redirect_to user_url(current_user)
    else
      render :new
    end
  end

  def show
    @goal = Goal.find_by(id: params[:id])
    render :show
  end

  def destroy
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :details, :private, :completed)
  end
end
