class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|

      t.datetime :date
      t.integer :user_id
      t.string :patient_name
    end
  end
end
