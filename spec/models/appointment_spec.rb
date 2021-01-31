require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe 'invalid appointments' do
    it 'should not be valid without a user_id' do
      appointment = Appointment.new(user_id: nil, time: '16:30', date: '2020-11-04')
      expect(appointment).to_not be_valid
    end

    it 'should not be valid without a time' do
      appointment = Appointment.new(user_id: 1, time: nil, date: '2020-11-04')
      expect(appointment).to_not be_valid
    end

    it 'should not be valid without a date' do
      appointment = Appointment.new(user_id: 1, time: '16:30', date: nil)
      expect(appointment).to_not be_valid
    end
  end

  it 'should be valid' do
    appointment = Appointment.new(user_id: 1, time: '16:30', date: '2020-11-04', schedule_datetime: Time.parse('2020-11-04 16:30'))
    expect(appointment).to be_valid
  end
end
