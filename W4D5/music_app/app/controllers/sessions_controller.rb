class SessionsController < ApplicationController
  before_action :require_logged_in, only: [:destroy]
  before_action :require_logged_out, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if @user
      login!(@user)
      redirect_to user_url(@user.id)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << 'Invalid credentials.'
      @user = User.new(email: params[:user][:email])
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
