class AddDatetoAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :date, :date
  end
end
