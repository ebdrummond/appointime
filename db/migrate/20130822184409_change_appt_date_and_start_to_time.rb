class ChangeApptDateAndStartToTime < ActiveRecord::Migration
  def change
    remove_column :appointments, :start
    remove_column :appointments, :date
    add_column :appointments, :start_time, :datetime
  end
end
