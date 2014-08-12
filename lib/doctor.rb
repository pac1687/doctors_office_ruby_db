class Doctor
  attr_reader :id, :name, :specialty_id, :insurance_id

  def initialize(attributes)
    @id = attributes['id'].to_i
    @name = attributes['name']
    @specialty_id = attributes['specialty_id'].to_i
    @insurance_id = attributes['insurance_id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.id == another_doctor.id && self.specialty_id == another_doctor.specialty_id && self.insurance_id == another_doctor.insurance_id
  end

  def save
    results = DB.exec("INSERT INTO doctors (name) VALUES ('#{@name}') RETURNING id;")
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

  def assign_specialty(doctor_id, specialty_id)
    DB.exec("UPDATE doctors SET specialty_id = #{specialty_id} WHERE id = #{doctor_id};")
    @specialty_id = specialty_id
    @name = name
  end

  def assign_insurance(doctor_id, insurance_id)
    results = DB.exec("UPDATE doctors SET insurance_id = #{insurance_id} WHERE id =#{doctor_id}")
    @insurance_id = insurance_id
  end

  def self.list_doctors_by_specialty(name)
    specialty_results = DB.exec("SELECT * FROM specialties WHERE name = '#{name}';")
    @id = specialty_results.first['id'].to_i
    results = DB.exec("SELECT * FROM doctors WHERE specialty_id = #{@id};")
    doctors = []
    results.each do |result|
      new_doctor = Doctor.new(result)
      doctors << new_doctor
    end
  doctors
  end

  def self.search_doctor(name)
    results = DB.exec("SELECT * FROM doctors WHERE name = '#{name}';")
    @id = results.first['id'].to_i
    doctors = []
    results.each do |result|
      new_doctor = Doctor.new(result)
      doctors << new_doctor
    end
    doctors
  end

  def self.update(name, id)
    DB.exec("UPDATE doctors SET name = '#{name}' WHERE id = #{id};")
    @name = name
  end

  def self.patient_count(id)
    results = DB.exec("SELECT COUNT(doctor_id) FROM patients WHERE doctor_id = #{id};")
    @count = results.first['count'].to_i
  end
end
