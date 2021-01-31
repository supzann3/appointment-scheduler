class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.datetime :schedule_datetime
      t.string :date
      t.string :time

      t.timestamps
    end
  end
end
