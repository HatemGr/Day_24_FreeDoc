# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Doctor.destroy_all
Patient.destroy_all
Appointment.destroy_all
City.destroy_all
Specialty.destroy_all
JoinTableDoctorSpecialty.destroy_all

### Create a list of 20 cities
20.times do
  City.create(city_name: Faker::Address.city)
end

### Create a list of 15 specialities
15.times do |index|
  Specialty.create(speciality_name: "Speciality #{index + 1}")
end

### Create 50 doctors and patients
50.times do
  Doctor.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, 
    zip_code: Faker::Number.number(digits: 5).to_s, city: City.all.sample)

  Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, city: City.all.sample)
end

### Give one specialty to each doctor
Doctor.all.each do |doctor|
  JoinTableDoctorSpecialty.create(doctor: doctor,specialty: Specialty.all.sample)
end

### Add 50 extra doc/specialty combination
50.times do
  JoinTableDoctorSpecialty.create(doctor: Doctor.all.sample,specialty: Specialty.all.sample)
end

### Create 400 appointments
400.times do
  appointment_city = City.all.sample
  Appointment.create(date: Faker::Time.between_dates(from: Date.today - 60, to: Date.today, period: :day),
  doctor: Doctor.where(city: appointment_city).sample,patient: Patient.where(city: appointment_city).sample, city: appointment_city)
end