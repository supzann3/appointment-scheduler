class AppointmentController < ApplicationController
  before_action :set_appointment, only: [:update, :destroy]

  def index
    @appointments = Appointment.all
    json_response(@appointments)
  end

  # POST /appointments
  # date time should be passed in this format
  # id: 1, date "2020-11-04", time: "16:29"
  def create
    user_id = appointment_params["user_id"]
    date = appointment_params["date"]
    time = appointment_params["time"]
    schedule_datetime = Time.parse(date + " " + time)
    # cannot make an appointment for the same date

    # cannot select a date and time in the past
    if Time.now > schedule_datetime
      message = { "message": "cannot create appointment #{date} #{time}, because it is in the past"}
      return json_response(message.to_json)
    end

    existing_appt = Appointment.where(user_id: user_id, date: date, time: time).first
    if !existing_appt.nil?
      message = { "message": "You already have an appointment for #{existing_appt.date} #{existing_appt.time}"}
      # cannot be created due to that the customer already have an appt that date
      return json_response(message.to_json)
    end

    appt = Appointment.where(user_id: user_id, date: date).first

    if appt.nil?
      @appointment = Appointment.create(user_id: user_id, schedule_datetime: schedule_datetime, date: date, time: time)
      return json_response(@appointment, :created)
    else
      message = { "message": "cannot create a new appointment, due to that you already have an appointment for #{appt.date} #{appt.time}"}
      # cannot be created due to that the customer already have an appt that date
      return json_response(message.to_json)
    end
  end

  # GET all user appointments /appointments/:id
  def show
    json_response(@appointment)
  end

  def show_user_appointments
    appointments = Appointment.where(user_id: params[:user_id])
    json_response(appointments)
  end

  # change appointment
  # PUT /appointments/:id
  # still need testing
  def update
    date = appointment_params["date"]
    time = appointment_params["time"]
    schedule_datetime = Time.parse(date + " " + time)

    # cannot select a date and time in the past
    if Time.now > schedule_datetime
      message = { "message": "cannot create appointment #{date} #{time}, because it is in the past"}
      return json_response(message.to_json)
    end

    @appointment.update(schedule_datetime: schedule_datetime, date: date, time: time)
    head :no_content
  end

  # DELETE /appointment/:id
  # or cancel appointment
  def destroy
    @appointment.destroy
    head :no_content
  end

  private

  def appointment_params
    # whitelist params
    params.permit(:user_id, :date, :time)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
