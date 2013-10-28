class SwitchStartTimetoTime < ActiveRecord::Migration
  def change
    change_column :appointments, :start_time, :time
  end
end
