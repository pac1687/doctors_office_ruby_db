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

  it 'lets you search a speciality by name and returns the id' do
    test_specialty = Specialty.new({'name' => "gynecologist"})
    test_specialty.save
    test_search = "gynecologist"
    result = Specialty.search_speciality(test_search)
    expect(result).to eq test_specialty.id
  end

  it 'updates speciality' do
    test_specialty = Specialty.new({'name' => "gynecologist"})
    test_specialty.save
    test_search = "gynecologist"
    test_update = "podiatrist"
    search = Specialty.search_speciality(test_search)
    result = Specialty.update(test_update, search)
    expect(Specialty.all.first.name).to eq "podiatrist"
  end
end
