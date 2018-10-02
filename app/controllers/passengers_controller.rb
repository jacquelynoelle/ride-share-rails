class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(:name)
  end

  def show
    @passenger = Passenger.find_by(id: params[:id].to_i)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
