class DriversController < ApplicationController
  def index
    @drivers = Driver.where(is_active: true).order(:name)
  end

  def show
    id = params[:id].to_i
    @driver = Driver.find_by(id: id)

    if @driver.nil? || !@driver.is_active
      render :notfound, status: :not_found
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to driver_path(driver.id)
    else
      render :new #the new driver form should show the error messages
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id].to_i)

    if @driver.nil? || !@driver.is_active
      render :notfound, status: :not_found
    end
  end

  def update
    driver = Driver.find_by(id: params[:id].to_i)
    driver.update(driver_params)

    redirect_to driver_path(driver.id)
  end

  def destroy
    @deleted_driver = Driver.find_by(id: params[:id].to_i)
    @deleted_driver.update(is_active: false)
  end

  private
    def driver_params
      return params.require(:driver).permit(:id, :name, :vin)
    end

end
