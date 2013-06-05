class ChangeStartsSaveToTime < ActiveRecord::Migration
  def change
    remove_column :appointments, :start
    add_column :appointments, :start, :time
  end
end
