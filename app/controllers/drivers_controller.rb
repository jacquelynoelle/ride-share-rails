class DriversController < ApplicationController
  def index
    @drivers = Driver.all.order(:name)
  end

  def show
    id = params[:id].to_i
    @driver = Driver.find_by(id: id)

    if @driver.nil?
      render :notfound, status: :not_found
    end
  end

  def new
  end

  def create
  end

  def edit
    @driver = Driver.find(params[:id].to_i)
  end

  def update
  end

  def destroy
    @deleted_driver = Driver.find_by(id: params[:id].to_i)
    @deleted_driver.destroy
    redirect_to drivers_path
  end
end
