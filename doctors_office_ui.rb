require './lib/doctor'
require './lib/patient'
require './lib/specialty'
require './lib/insurance'
require './lib/appointments'
require 'pg'
require 'pry'
require 'time'

DB = PG.connect(:dbname => 'doctors_office')

@search

def main_menu

  puts "\n\n-- Doctor's Office --\n\n"

  puts "Enter your option:"
  puts "Press '1' for Doctor menu."
  puts "Press '2' to list out doctors."
  puts "Press '3' for Patient menu."
  puts "Press 'x' to exit the program."

  user_decision = gets.chomp

  if user_decision == '1'
    doctor_menu
  elsif user_decision == '2'
    list_doctors
  elsif user_decision == '3'
    patient_menu
  elsif user_decision == 'x'
    puts "Goodbye, Justin!"
    exit
  else
    puts "Invalid."
    main_menu
  end

end

def doctor_menu

  puts "\n\n-- Doctor Menu --\n\n"

  puts "Enter your option:"
  puts "Press '1' to add doctor to roster."
  puts "Press '2' to search for doctor."
  puts "Press '3' to create a specialty."
  puts "Press '4' to list out doctors."
  puts "Press '5' to update doctor information."
  puts "Press 'x' to go back to main menu."

  user_decision = gets.chomp

  if user_decision == '1'
    add_doctor
  elsif user_decision == '2'
    search_doctor
  elsif user_decision == '3'
    create_specialty
  elsif user_decision == '4'
    list_doctors
  elsif user_decision == '5'
    update_doctor
  elsif user_decision == 'x'
    puts "Goodbye, Justin!"
    main_menu
  else
    puts "Invalid."
    doctor_menu
  end

end

def add_doctor
  puts "\n\n-- Add Doctor --\n\n"
  puts "Enter new doctor name:"
  user_decision = gets.chomp
  new_doctor = Doctor.new({'name' => user_decision})
  new_doctor.save
  puts "#{new_doctor.name} has been added."
  doctor_menu
end

def list_doctors
  puts "\n\n-- List of Doctors --\n\n"
  Doctor.all.each_with_index { |doctor, index| puts "#{index+1}. #{doctor.name}"}
  main_menu
end

def create_specialty
  puts "\n\n-- Create Specialty --\n\n"
  puts "Enter new specialty:"
  user_decision = gets.chomp
  new_specialty = Specialty.new({'name' => user_decision})
  new_specialty.save
  puts "#{new_specialty.name} has been added."
  doctor_menu
end

def search_doctor
  puts "\n\n-- Search for Doctor --\n\n"
  puts "Enter name of doctor:"
  user_decision = gets.chomp
  result = Doctor.search_doctor(user_decision)
  result = result.first
  puts "Search result:"
  puts "ID: #{result.id}"
  puts "Name: #{result.name}"
  puts "Specialty ID: #{result.specialty_id}"
  puts "Insurance ID: #{result.insurance_id}"
  doctor_menu
end

def update_doctor
  puts "\n\n-- Update Doctor --\n\n"
  puts "Press '1'to update a doctor's name"
  puts "Press '2' to update a doctor's specialty"
  puts "Press '3' to update a doctor's insurance"
  puts "Press 'x' to return to the doctor menu"

  user_decision = gets.chomp

  Doctor.all.each do |doctor|
    puts "#{doctor.id}. #{doctor.name}"
    puts "Speciality ID: #{doctor.specialty_id}"
    puts "Insurance ID: #{doctor.insurance_id}"
  end

  if user_decision == '1'
    puts "Enter index number of doctor to update:"
    user_index = gets.chomp.to_i
    puts "Enter the new name:"
    new_name = gets.chomp
    @current_doctor = Doctor.update(new_name, user_index)
    puts "#{@current_doctor} has been updated!"
    update_doctor
  elsif user_decision == '2'
    puts "Enter index number of doctor to update:"
    user_index = gets.chomp.to_i
    Specialty.all.each do |specialty|
      puts "#{specialty.id}. #{specialty.name}"
    end
    puts "Enter index to assign speciality to doctor."
    specialty_index = gets.chomp.to_i
    binding.pry
    Doctor.assign_specialty(user_index, specialty_index)

    puts "#{specialty_index} has been saved."
  end



end


main_menu
