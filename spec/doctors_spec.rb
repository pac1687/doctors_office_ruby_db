require 'doctors_spec_helper'

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
    test_doctor.assign_specialty(test_doctor.id, test_specialty.id)
    expect(test_doctor.specialty_id).to eq test_specialty.id
  end

  it 'lists out all the doctors in a particular speciality' do
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

end
