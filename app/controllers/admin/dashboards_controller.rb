class Admin::DashboardsController < ApplicationController
  before_filter :require_admin

  def show
    @disable_sidebar = true
    @weekly_appointments = Appointment.for_this_week
    @weekly_appointments_next = Appointment.for_next_week
  end
end