class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #TODO call @user.login! when built
      # flash.now[:notice] = "Welcome to Catopia"
      redirect_to cats_url
    else
      flash.now[:errors] ||= []
      flash.now[:errors].concat(@user.errors.full_messages)
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
