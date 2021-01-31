class Appointment < ApplicationRecord

  validates_presence_of :user_id, :date, :time
end
