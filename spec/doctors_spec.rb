require 'doctors_spec_helper'

describe Doctor do
  it 'should initialize doctor name and speciality' do
    test_doctor = Doctor.new({'name' => "Dr. Who", 'specialty' => "gynecologist"})
    expect(test_doctor).to be_an_instance_of Doctor
  end

  it 'lets you save a doctor to the database' do
    test_doctor = Doctor.new({'name' => "Dr. Who", 'specialty' => "gynecologist"})
    test_doctor.save
    expect(Doctor.all).to eq [test_doctor]
  end
end
