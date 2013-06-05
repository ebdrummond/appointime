u1 = User.create(first_name: "Meghan",
                 last_name: "Peters",
                 email: "meghan.peters10@gmail.com",
                 password: "yes",
                 password_confirmation: "yes",
                 phone: "5866048834")
u1.admin = true
u1.save

u2 = User.create(first_name: "Erin",
                 last_name: "Drummond",
                 email: "e.b.drummond@gmail.com",
                 password: "yes",
                 password_confirmation: "yes",
                 phone: "2022555854")

u3 = User.create(first_name: "Brock",
                 last_name: "Boland",
                 email: "brock@brockboland.com",
                 password: "yes",
                 password_confirmation: "yes",
                 phone: "2023745348")

count = 0
100.times do |u|
  count += 1
  puts "user #{count}"
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(first_name: "#{first_name}",
                last_name: "#{last_name}",
                email: "example#{count}@example.com",
                password: "password",
                password_confirmation: "password",
                phone: "1112223333")
end

Appointment.create(date: Date.new(2013, 6, 4),
                   user_id: u2.id,
                   start: Clock.new(8).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 4),
                   user_id: u3.id,
                   start: Clock.new(9, 30).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 4),
                   user_id: 14,
                   start: Clock.new(12,30).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 4),
                   user_id: 66,
                   start: Clock.new(15).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 5),
                   user_id: 4,
                   start: Clock.new(10).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 5),
                   user_id: 52,
                   start: Clock.new(12, 30).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 5),
                   user_id: 88,
                   start: Clock.new(16).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 6),
                   user_id: 99,
                   start: Clock.new(8, 30).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 6),
                   user_id: 7,
                   start: Clock.new(11, 30).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 6),
                   user_id: 34,
                   start: Clock.new(14).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 6),
                   user_id: 84,
                   start: Clock.new(15).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 7),
                   user_id: 21,
                   start: Clock.new(16).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 7),
                   user_id: 79,
                   start: Clock.new(17).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 8),
                   user_id: 50,
                   start: Clock.new(10, 30).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 8),
                   user_id: 52,
                   start: Clock.new(12).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 8),
                   user_id: 44,
                   start: Clock.new(14, 30).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 8),
                   user_id: 90,
                   start: Clock.new(16, 30).time,
                   duration: "90")