require 'doctors_spec_helper'

describe Patient do
  it 'should initialize patient name, birthday, & doctor id' do
    test_patient = Patient.new({'name' => "Sherlock Holmes", 'birthday' => "1999-09-09", 'doctor_id' => 1})
    expect(test_patient).to be_an_instance_of Patient
  end

  it 'lets you save a patient to the database' do
    test_patient = Patient.new({'name' => "Sherlock Holmes", 'birthday' => "1999-09-09", 'doctor_id' => 1})
    test_patient.save
    expect(Patient.all).to eq [test_patient]
  end

  it 'lets you assign a patient to a doctor' do
    test_doctor = Doctor.new({'name' => "Dr. Who", 'specialty' => "gynecologist"})
    test_doctor.save
    test_patient = Patient.new({'name' => "Sherlock Holmes", 'birthday' => "1999-09-09", 'doctor_id' => 1})
    test_patient.save
    test_patient.assign_doctor(test_doctor.id, test_patient.id)
    expect(test_patient.doctor_id).to eq test_doctor.id
  end

  it 'lets you search a patient by name and returns the id' do
    test_patient = Patient.new({'name' => "Sherlock Holmes", 'birthday' => "1999-09-09", 'doctor_id' => 1})
    test_patient.save
    test_search = "Sherlock Holmes"
    result = Patient.search_patient(test_search)
    expect(result).to eq test_patient.id
  end

  it 'updates the name of the patient' do
    test_patient = Patient.new({'name' => "Sherlock Holmes", 'birthday' => "1999-09-09", 'doctor_id' => 1})
    test_patient.save
    test_search = "Sherlock Holmes"
    test_update = "John Watson"
    search = Patient.search_patient(test_search)
    result = Patient.update(test_update, search)
    expect(Patient.all.first.name).to eq "John Watson"
  end
end
