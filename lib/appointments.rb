require 'time'

class Appointment
  attr_reader :id, :doctor_id, :patient_id, :date, :cost

  def initialize(attributes)
    @id = attributes['id'].to_i
    @doctor_id = attributes['doctor_id'].to_i
    @patient_id = attributes['patient_id'].to_i
    @date = Time.new(attributes['date'])
    @cost = attributes['cost'].to_i
  end

  def ==(another_appointment)
    self.id == another_appointment.id && self.doctor_id == another_appointment.doctor_id && self.patient_id == another_appointment.patient_id && self.date == another_appointment.date && self.cost == another_appointment.cost
  end

  def save
    results = DB.exec("INSERT INTO appointments (doctor_id, patient_id, date, cost) VALUES (#{@doctor_id}, #{@patient_id}, '#{date}', #{cost}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM appointments;")
    appointments = []
    results.each do |result|
      new_appointment = Appointment.new(result)
      appointments << new_appointment
    end
    appointments
  end
end
