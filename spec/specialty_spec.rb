require 'doctors_spec_helper'

describe Specialty do
  it 'should initialize specialty name' do
    test_specialty = Specialty.new({'name' => "gynecologist"})
    expect(test_specialty).to be_an_instance_of Specialty
  end

  it 'lets you save a specialty to the database' do
    test_specialty = Specialty.new({'name' => "gynecologist"})
    test_specialty.save
    expect(Specialty.all).to eq [test_specialty]
  end
end
