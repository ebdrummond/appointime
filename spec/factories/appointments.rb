FactoryGirl.define do
  factory :appointment do
    start_time  Clock.new(9, 30).time
    date        Date.today
    duration    90
  end
end