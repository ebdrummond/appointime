require 'spec_helper'

describe EmailsWorker do
  let!(:appt){stub(id: 1)}

  xit "queues a job to the Sidekiq queue" do
    worker = EmailsWorker.new
    expect {worker.perform(appt.id)}.to change(EmailsWorker.jobs, :size).by(1)
  end
end