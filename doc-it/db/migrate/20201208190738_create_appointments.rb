class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|

      t.date :date
      t.time :time
      t.integer :user_id
      t.integer :doctor_id
      t.string :doctor_name
      t.string :patient_name
    end
  end
end
