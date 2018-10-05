class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver
end

# def assign_driver
