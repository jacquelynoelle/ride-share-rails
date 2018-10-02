class Passenger < ApplicationRecord
  has_many :trips

  def list_trips
    return self.trips.where(passenger_id: id)
  end
end
