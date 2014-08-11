require 'doctors_spec_helper'

describe Appointment do
  it 'should initalize doctor, patient, date and cost' do
    test_doctor = Doctor.new({'name' => "Dr. Who"})
    test_doctor.save
    test_patient = Patient.new({'name' => "Sherlock Holmes", 'birthday' => "1999-09-09", 'doctor_id' => test_doctor.id})
    test_patient.save
    test_patient.assign_doctor(test_doctor.id, test_patient.id)
    test_appointment = Appointment.new({'doctor_id' => test_doctor.id, 'patient_id' => test_patient.id, 'date' => '2000-01-01', 'cost' => 5000})
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
end
