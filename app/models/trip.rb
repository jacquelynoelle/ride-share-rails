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

  def get_driver
    drivers = Driver.all
    selected_driver_id = nil
    while selected_driver_id.nil?
      driver = drivers[rand(drivers.length)]
      selected_driver_id = driver.dispatch
    end
    return selected_driver_id
  end

  def start_trip(pass_id)
    self.date = Date.today
    self.rating = nil
    self.cost = 500 + rand(5000)
    # self.driver_id = select_driver.id
    self.driver_id = get_driver
    self.passenger_id = pass_id
  end

  def display_cost
    dollar_cost = "$#{(self.cost * 0.01).round(2)}"
  end
end
