require 'rails_helper'

RSpec.describe AppointmentController, type: :controller do
  let!(:appointments) { create_list(:appointment, 5)}
  let!(:user_id) { appointments.first.user_id}

  describe 'GET user/appointments' do
    before { get :show_user_appointments, params: { user_id: user_id } }
    it 'returns a list of the user appointments' do
      expect(response).to have_http_status(200)
    end

    it 'returns todos' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
  end

  describe 'POST /appointments' do
    context 'when request is valid' do
      let(:datetime) { Time.now + 2.days }
      let(:valid_attributes) { {user_id: 2, time: '13:30', date: datetime.strftime("%F")}}

        it 'should create an appointment' do
          post :create, params: valid_attributes
          json = JSON.parse(response.body)
          expect(json['user_id']).to eq(valid_attributes[:user_id])
          expect(json['time']).to eq(valid_attributes[:time])
          expect(json['date']).to eq(valid_attributes[:date])
        end
    end

    context 'invalid appointments in the past' do
      let(:datetime) { 2.days.ago }
      let(:valid_attributes) { {user_id: 2, time: '13:30', date: datetime.strftime("%F")}}

      it 'should not create an appointment' do
        post :create, params: valid_attributes
        json = JSON.parse(response.body)
        message = "cannot create appointment #{datetime.strftime("%F")} #{valid_attributes[:time]}, because it is in the past"
        expect(json['message']).to eq(message)
      end
    end

    context 'invalid appointments for the same date and time' do
      let(:date) { appointments.first.date }
      let(:time) { appointments.first.time }
      let(:valid_attributes) { {user_id: user_id, time: time, date: date}}

      it 'should not create an appointment on the same day and time' do
        post :create, params: valid_attributes
        json = JSON.parse(response.body)
        message = "You already have an appointment for #{date} #{time}"
        expect(json['message']).to eq(message)
      end
    end

    context 'invalid appointments for the same date' do
      let(:date) { appointments.first.date }
      let(:time) { '17:30' }
      let(:valid_attributes) { {user_id: user_id, time: time, date: date}}
      it 'should not create an appointment on the same day' do
        post :create, params: valid_attributes
        json = JSON.parse(response.body)
        message = "cannot create a new appointment, due to that you already have an appointment for #{date} #{appointments.first.time}"
        expect(json['message']).to eq(message)
      end
    end
  end
end
