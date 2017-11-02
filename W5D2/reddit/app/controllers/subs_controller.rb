class SubsController < ApplicationController
  before_action :require_logged_in, except: [:index, :show]

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :show
    else
      redirect_to subs_url
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :edit
    else
      redirect_to subs_url
    end
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    if @sub.update(sub_params)
      render :show
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
