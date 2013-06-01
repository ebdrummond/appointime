class SaveAppointmentStartAsString < ActiveRecord::Migration
  def change
    remove_column :appointments, :start
    add_column :appointments, :start, :string
  end
end
