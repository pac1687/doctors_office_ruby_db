class Doctor
  attr_reader :id, :name, :specialty

  def initialize(attributes)
    @id = attributes['id']
    @name = attributes['name']
    @specialty = attributes['specialty']
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      new_doctor = Doctor.new(result)
      doctors << new_doctor
    end
  doctors
  end
end
