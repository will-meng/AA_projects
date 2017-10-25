class CatRentalRequestsController < ApplicationController
  def index
    @cat_rental_requests = CatRentalRequest.all
    render :index


  end

  def show
    @cat_rental_request = CatRentalRequest.joins(:cat)
      .select('cat_rental_requests.*, cats.name')
      .where(id: params[:id]).first


    render :show
  end

  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def edit
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    render :edit
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

    if @cat_rental_request.save
      redirect_to cat_rental_request_url(@cat_rental_request.id)
    else
      render :new
    end
  end

  def update
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])

    if @cat_rental_request.update(cat_rental_request_params)
      redirect_to cat_rental_request_url(@cat_rental_request.id)
    else
      render :edit
    end

  end

  private
  def cat_rental_request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :start_date, :end_date, :status)
  end

end
