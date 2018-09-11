# ユーザー
10.times do |n|
  name  = Faker::Name.name
  email = "example#{n+1}@example.com"
  password = "password"
  User.create!(
    name:     name,
    email:    email,
    password:              password,
    password_confirmation: password)
end

# FP
10.times do |n|
  name  = Faker::Name.name
  email = "example#{n+1}@example.com"
  password = "password"
  Fp.create!(
    name:     name,
    email:    email,
    password:              password,
    password_confirmation: password)
end

# Reservations
10.times do |n|
  user = User.first
  fp   = Fp.first
  reserved_on = DateTime.new(2019, 9, 1, 10, 30, 00, 0.375) + (30*n).minutes
  Reservation.create!(
    fp_id:       fp.id,
    user_id:     user.id,
    reserved_on: reserved_on
  )
end

# Fp_reservable_times
10.times do |n|
  fp            = Fp.first
  reservable_on = DateTime.new(2019, 9, 2, 10, 30, 00, 0.375) + (30*n).minutes
  FpReservableTime.create!(
    fp_id:         fp.id,
    reservable_on: reservable_on
  )
end
