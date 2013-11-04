require 'spec_helper'
require 'sidekiq/testing'

describe EmailsWorker do
  let(:user){ FactoryGirl.create(:user) }
  let(:appointment) { FactoryGirl.create(:appointment, user: user) }

  #TODO: This test doesn't seem very strong; is there a better way to test?
  it "queues a job to the Sidekiq queue" do
    expect(EmailsWorker.new.perform(appointment.id)).to be_true
  end
end