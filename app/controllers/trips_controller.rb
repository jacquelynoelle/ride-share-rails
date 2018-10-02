class TripsController < ApplicationController
  def index
    @trip = Trip.all.order(:date)
  end

  def show
    @trip = Trip.find_by(id: params[:id].to_i)
  end

  def new
    @trip = Trip.new
  end

  def create
    trip = Trip.new(trip_params) #instantiate a new book

    if trip.save
      redirect_to trip_path(trip.id)
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id].to_i)
  end

  def update
    trip = Trip.find_by(id: params[:id].to_i)
    trip.update(trip_params)

    redirect_to trip_path(trip.id)
  end

  def destroy
    trip_to_delete = Trip.find_by(id: params[:id].to_i)
    trip_to_delete.destroy

    redirect_to trips_path
  end

  private

    def trip_params
      return params.require(:trip).permit(:id, :name, :phone_num)
    end
end
