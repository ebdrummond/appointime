class Emailer < ActionMailer::Base
  default from: 'newleafmassage1@gmail.com'

  def confirmation_email(appointment)
    @appointment = appointment
    mail( to: @appointment.user.email,
          subject: "Appointment confirmed!" )
  end

  def update_email(appointment)
    @appointment = appointment
    mail( to: @appointment.user.email,
          subject: "Appointment updated!" )
  end

  def meghan_confirmation_email(appointment)
    @appointment = appointment
    mail( to: "newleafmassageandwellness@gmail.com",
          subject: "Fake appointment scheduled!")
  end
end