class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.date       :date
      t.datetime   :start
      t.datetime   :ending
      t.boolean    :blocked, :default => false
      t.references :user

      t.timestamps
    end
  add_index :appointments, :user_id
  end
end
