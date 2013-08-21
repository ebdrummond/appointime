require 'spec_helper'

describe EmailsWorker do
  let(:user){ User.create(first_name: "Brock",
                          last_name: "Boland",
                          email: "brock@gmail.com",
                          password: "yes",
                          phone: "2022555854") }
  let(:appointment) { Appointment.create(date: Date.new(2013, 7, 10),
                                         user_id: user.id,
                                         duration: 90,
                                         start: Clock.new(11).time) }

  xit "queues a job to the Sidekiq queue" do
    worker = EmailsWorker.new
    expect {worker.perform(appointment.id)}.to change(EmailsWorker.jobs, :size).by(1)
  end
end