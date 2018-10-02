class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(:name)
  end

  def show
    @passenger = Passenger.find_by(id: params[:id].to_i)
  end

  def new
    @passenger = Passenger.new
  end

  def create
    passenger = Passenger.new(passenger_params) #instantiate a new book

    if passenger.save
      redirect_to passenger_path(passenger.id)
    else
      render :new
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id].to_i)
  end

  def update
    passenger = Passenger.find_by(id: params[:id].to_i)
    passenger.update(passenger_params)

    redirect_to passenger_path(passenger.id)
  end

  def destroy
    passenger_to_delete = Passenger.find_by(id: params[:id].to_i)
    passenger_to_delete.destroy

    redirect_to passengers_path
  end

  private

    def passenger_params
      return params.require(:passenger).permit(:id, :name, :phone_num)
    end
end
