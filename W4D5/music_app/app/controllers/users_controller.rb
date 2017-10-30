class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show]
  before_action :require_logged_out, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user.id)
    else
      flash.now[:errors] ||= []
      flash.now[:errors].concat(@user.errors.full_messages)
      render :new
    end
  end

  def show
    redirect_to bands_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
