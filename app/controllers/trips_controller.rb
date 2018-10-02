class TripsController < ApplicationController
  def index
    @trip = Trips.all.order(:name)
  end

  def show
    @trip = Trips.find_by(id: params[:id].to_i)
  end

  def new
    @trip = Trips.new
  end

  def create
    trip = Trips.new(trip_params) #instantiate a new book

    if trip.save
      redirect_to trip_path(trip.id)
    else
      render :new
    end
  end

  def edit
    @trip = Trips.find_by(id: params[:id].to_i)
  end

  def update
    trip = Trips.find_by(id: params[:id].to_i)
    trip.update(trip_params)

    redirect_to trip_path(trip.id)
  end

  def destroy
    trip_to_delete = Trips.find_by(id: params[:id].to_i)
    trip_to_delete.destroy

    redirect_to trips_path
  end

  private

    def trip_params
      return params.require(:trip).permit(:id, :name, :phone_num)
    end
end
