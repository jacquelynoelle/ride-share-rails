class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  validates :passenger_id, presence: true
  validates :driver_id, presence: true
  validates :date, presence: true
  validates :cost, presence: true

  def self.search(term, page)
    if term
      where('name LIKE ?', "%#{term}%").paginate(page: page, per_page: 20).order(date: :desc)
    else
      paginate(page: page, per_page: 20).order(date: :desc)
    end
  end

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

  def display_cost
    dollar_cost = "$#{(self.cost * 0.01).round(2)}"
  end
end
