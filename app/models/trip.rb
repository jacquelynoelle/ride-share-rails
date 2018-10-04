class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  def select_driver
    available_drivers = Driver.where(available: true)
    selected_driver = nil
    while selected_driver.nil?
      driver = available_drivers[rand(available_drivers.length)]
      if driver.available
        selected_driver = driver
        driver.available = false # set chosen driver unavailable
      end
    end
    return selected_driver
  end

  def start_trip(pass_id)
    self.date = Date.today
    self.rating = nil
    self.cost = 500 + rand(5000)
    self.driver_id = select_driver.id
    self.passenger_id = pass_id
  end

end
