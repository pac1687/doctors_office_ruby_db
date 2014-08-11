require 'doctors_spec_helper'

describe Appointment do
  it 'should initalize doctor, patient, date and cost' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    test_doctor.save
    test_patient = Patient.new({'name' => "Sherlock Holmes", 'birthday' => "1999-09-09", 'doctor_id' => test_doctor.id})
    test_patient.save
    test_patient.assign_doctor(test_doctor.id, test_patient.id)
    test_appointment = Appointment.new({'doctor_id' => test_doctor.id, 'patient_id' => test_patient.id, 'date' => '2000-02-01', 'cost' => 5000})
    expect(test_appointment).to be_an_instance_of Appointment
  end

  it 'should save an appointment to the database' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    test_doctor.save
    test_patient = Patient.new({'name' => "Sherlock Holmes", 'birthday' => "1999-09-09", 'doctor_id' => test_doctor.id})
    test_patient.save
    test_patient.assign_doctor(test_doctor.id, test_patient.id)
    test_appointment = Appointment.new({'doctor_id' => test_doctor.id, 'patient_id' => test_patient.id, 'date' => '2000-01-01', 'cost' => '5000'})
    test_appointment.save
    expect(Appointment.all).to eq [test_appointment]
  end

  it 'should sum the cost of multiple visits to the doctor' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    test_doctor.save
    test_patient = Patient.new({'name' => "Sherlock Holmes", 'birthday' => "1999-09-09", 'doctor_id' => test_doctor.id})
    test_patient.save
    test_patient.assign_doctor(test_doctor.id, test_patient.id)
    test_patient1 = Patient.new({'name' => "John Watson", 'birthday' => "1999-09-08", 'doctor_id' => test_doctor.id})
    test_patient1.save
    test_patient1.assign_doctor(test_doctor.id, test_patient1.id)
    test_appointment = Appointment.new({'doctor_id' => test_doctor.id, 'patient_id' => test_patient.id, 'date' => '2000-01-01', 'cost' => '5000'})
    test_appointment.save
    test_appointment1 = Appointment.new({'doctor_id' => test_doctor.id, 'patient_id' => test_patient1.id, 'date' => '2000-01-02', 'cost' => '3000'})
    test_appointment1.save
    test_search = "Dr. Who"
    date1 = "2000-01-01"
    date2 = "2000-01-02"
    search_result = Doctor.search_doctor(test_search)
    sum = Appointment.bill(search_result, date1, date2)
    expect(sum).to eq 8000
  end
end
