FactoryGirl.define do
  factory :user do
    first_name "Erin"
    last_name "Drummond"
    email "e.b.drummond@gmail.com"
    password_digest "password"
    phone "2022555854"
    admin false
  end
end