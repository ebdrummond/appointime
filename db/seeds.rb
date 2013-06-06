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

first_names = ["Erin", "Chris", "Nicole", "Laura", "Lauren", "Emma", "John", "Ashley", "Jennifer", "Rachel", "Jamie", "Paul", "Margaret", "Rob", "Michelle", "Jules", "Eric"]
last_names = ["Blackwell", "Maher", "Schorkopf", "Garcia", "Mejia", "Tellez", "Eliuk", "Battos", "Maddux", "Tai", "Knight", "Grant", "Steadman", "Weiner", "Mee", "Webber", "Casimir", "Owen", "Suss", "Rogers", "Komlo", "Sears", "Anderson", "Sheehan"]

count = 0
100.times do |u|
  count += 1
  puts "user #{count}"
  first_name = first_names.sample
  last_name = last_names.sample
  User.create(first_name: "#{first_name}",
                last_name: "#{last_name}",
                email: "example#{count}@example.com",
                password: "password",
                password_confirmation: "password",
                phone: "1112223333")
end

Appointment.create(date: Date.new(2013, 6, 3),
                   user_id: u2.id,
                   start: Clock.new(8).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 3),
                   user_id: u3.id,
                   start: Clock.new(9, 30).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 3),
                   user_id: 14,
                   start: Clock.new(12,30).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 3),
                   user_id: 66,
                   start: Clock.new(15).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 4),
                   user_id: 4,
                   start: Clock.new(10).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 4),
                   user_id: 52,
                   start: Clock.new(12, 30).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 4),
                   user_id: 88,
                   start: Clock.new(16).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 5),
                   user_id: 99,
                   start: Clock.new(8, 30).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 5),
                   user_id: 7,
                   start: Clock.new(11, 30).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 5),
                   user_id: 34,
                   start: Clock.new(14).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 5),
                   user_id: 84,
                   start: Clock.new(15).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 6),
                   user_id: 21,
                   start: Clock.new(16).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 6),
                   user_id: 79,
                   start: Clock.new(17).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 7),
                   user_id: 50,
                   start: Clock.new(10, 30).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 7),
                   user_id: 52,
                   start: Clock.new(12).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 7),
                   user_id: 44,
                   start: Clock.new(14, 30).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 7),
                   user_id: 90,
                   start: Clock.new(16, 30).time,
                   duration: "90")


Appointment.create(date: Date.new(2013, 6, 10),
                   user_id: u2.id,
                   start: Clock.new(8).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 10),
                   user_id: u3.id,
                   start: Clock.new(9, 30).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 10),
                   user_id: 37,
                   start: Clock.new(15).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 11),
                   user_id: 75,
                   start: Clock.new(12, 30).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 11),
                   user_id: 17,
                   start: Clock.new(16).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 12),
                   user_id: 98,
                   start: Clock.new(8, 30).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 12),
                   user_id: 6,
                   start: Clock.new(11, 30).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 12),
                   user_id: 83,
                   start: Clock.new(15).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 13),
                   user_id: 20,
                   start: Clock.new(16).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 13),
                   user_id: 78,
                   start: Clock.new(17).time,
                   duration: "60")
Appointment.create(date: Date.new(2013, 6, 14),
                   user_id: 49,
                   start: Clock.new(10, 30).time,
                   duration: "90")
Appointment.create(date: Date.new(2013, 6, 14),
                   user_id: 51,
                   start: Clock.new(12).time,
                   duration: "90")
