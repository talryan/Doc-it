class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|

      t.date :date
      t.time :time
      t.integer :user_id
      t.string :doctor_name
    end
  end
end
