require 'doctors_spec_helper'
require 'pry'

describe Doctor do
  it 'should initialize doctor name' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    expect(test_doctor).to be_an_instance_of Doctor
  end

  it 'lets you save a doctor to the database' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    test_doctor.save
    expect(Doctor.all).to eq [test_doctor]
  end

  it 'should assign doctor specialty' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    test_doctor.save
    test_specialty = Specialty.new({'name' => "gynecologist"})
    test_specialty.save
        binding.pry
    test_doctor.assign_specialty(test_doctor.id, test_specialty.id)

    expect(test_doctor.specialty_id).to eq test_specialty.id
  end

  it 'lists out all the doctors in a particular specialty' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    test_doctor.save
    test_specialty = Specialty.new({'name' => "gynecologist"})
    test_specialty.save
    test_doctor1 = Doctor.new({'name' => "Dr. Quinn"})
    test_doctor1.save
    test_doctor.assign_specialty(test_doctor.id, test_specialty.id)
    test_doctor1.assign_specialty(test_doctor1.id, test_specialty.id)
    specialty_search = "gynecologist"
    list_doctors = Doctor.list_doctors_by_specialty(specialty_search)
    expect(list_doctors).to eq [test_doctor, test_doctor1]
  end

  it 'should assign insurance company to doctor' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    test_doctor.save
    test_specialty = Specialty.new({'name' => "gynecologist"})
    test_specialty.save
    test_insurance = Insurance.new({'name' => "Red Shield"})
    test_insurance.save
    test_doctor.assign_specialty(test_doctor.id, test_specialty.id)
    test_doctor.assign_insurance(test_doctor.id, test_insurance.id)
    expect(test_doctor.insurance_id).to eq test_insurance.id
  end

  it 'searches for a doctor by name and returns the ID' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    test_doctor.save
    test_search = "Dr. Who"
    result = Doctor.search_doctor(test_search)
    expect(result.first.id).to eq test_doctor.id
  end

  it 'updates the name of the doctor' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    test_doctor.save
    test_search = "Dr. Who"
    test_update = "Dr. What"
    search = Doctor.search_doctor(test_search)
    result = Doctor.update(test_update, search.id)
    expect(Doctor.all.first.name).to eq "Dr. What"
  end

  it 'returns the number of patients a doctor sees' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    test_doctor.save
    test_patient = Patient.new({'name' => "Sherlock Holmes", 'birthday' => "1999-09-09", 'doctor_id' => test_doctor.id})
    test_patient.save
    test_patient1 = Patient.new({'name' => "John Watson", 'birthday' => "1999-09-08", 'doctor_id' => test_doctor.id})
    test_patient1.save
    test_search = "Dr. Who"
    search = Doctor.search_doctor(test_search)
    result = Doctor.patient_count(search)
    expect(result).to eq 2
  end
end
