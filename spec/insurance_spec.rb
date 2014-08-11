require 'doctors_spec_helper.rb'

describe Insurance do
  it 'should initialize insurance company name' do
    test_insurance = Insurance.new({'name' => 'Red Shield'})
    expect(test_insurance).to be_an_instance_of Insurance
  end

  it 'lets you save an insurance company to the database' do
    test_insurance = Insurance.new({'name' => 'Red Shield'})
    test_insurance.save
    expect(Insurance.all).to eq [test_insurance]
  end

  it 'lets you search an insurance company by name and returns the id' do
    test_insurance = Insurance.new({'name' => "Red Shield"})
    test_insurance.save
    test_search = "Red Shield"
    result = Insurance.search_insurance(test_search)
    expect(result).to eq test_insurance.id
  end

  it 'updates the name of the patient' do
    test_insurance = Insurance.new({'name' => "Red Shield"})
    test_insurance.save
    test_search = "Red Shield"
    test_update = "Blue Cross"
    search = Insurance.search_insurance(test_search)
    result = Insurance.update(test_update, search)
    expect(Insurance.all.first.name).to eq "Blue Cross"
  end
end
