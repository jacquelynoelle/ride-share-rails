class TripsController < ApplicationController
  def index
    @trips = Trip.search(params[:term], params[:page])
  end

  def show
    @trip = Trip.find_by(id: params[:id].to_i)

    if @trip.nil?
      render :notfound, status: :not_found
    end
  end

  def create
    if params[:passenger_id] # Nested route: /passenger/:passenger_id/trips/
      pax_id = params[:passenger_id].to_i
      passenger = Passenger.find_by(id: pax_id)
      @trip = Trip.new
      @trip.start_trip(pax_id)
      if @trip.save
        redirect_to passenger_path(pax_id)
      end
    else
      render :notfound, status: :not_found
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id].to_i)
  end

  def update
    @trip = Trip.find_by(id: params[:id].to_i)
    if @trip.update(trip_params)
      redirect_to trip_path(id: params[:id].to_i)
    else
      render :edit
    end
  end

  def destroy
    @deleted_trip = Trip.find_by(id: params[:id].to_i)
    @deleted_trip.destroy
  end

  private

    def trip_params
      return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
    end
end
