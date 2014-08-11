class Patient
  attr_reader :id, :name, :birthday, :doctor_id

  def initialize(attributes)
    @id = attributes['id']
    @name = attributes['name']
    @birthday = attributes['birthday']
    @doctor_id = attributes['doctor_id']
  end

  def ==(another_patient)
    self.name == another_patient.name
  end

  def save
    results = DB.exec("INSERT INTO patients (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', #{@doctor_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |result|
      new_patient = Patient.new(result)
      patients << new_patient
    end
  patients
  end

  def assign_doctor(doctor_id, patient_id)
    results = DB.exec("UPDATE patients SET doctor_id = #{doctor_id} WHERE id = #{patient_id} RETURNING doctor_id;")
    @doctor_id = results.first['doctor_id'].to_i
  end

  def self.search_patient(name)
    results = DB.exec("SELECT * FROM patients WHERE name = '#{name}';")
    @id = results.first['id'].to_i
  end

  def self.update(name, id)
    DB.exec("UPDATE patients SET name = '#{name}' WHERE id = #{id};")
    @name = name
  end
end
