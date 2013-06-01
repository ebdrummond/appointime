class RemoveEndingAddDuration < ActiveRecord::Migration
  def change
    remove_column :appointments, :ending
    add_column :appointments, :duration, :integer
  end
end
