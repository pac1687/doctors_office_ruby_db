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

end
