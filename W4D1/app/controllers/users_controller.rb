class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user
    else
      render plain: "user not found", status: 422
    end
  end

  def update
    user = User.find_by(id: params[:id])
    unless user
      render plain: 'user not found'
      return
    end
    if user.update(user_params)
      render json: user
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user
      user.destroy
      render json: user
    else
      render plain: "cannot find user to destroy", status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
