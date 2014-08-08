class Specialty
  attr_reader :id, :name

  def initialize(attributes)
    @id = attributes['id']
    @name = attributes['name']
  end

  def ==(another_specialty)
    self.name == another_specialty.name
  end

  def save
    results = DB.exec("INSERT INTO specialties (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM specialties;")
    specialties = []
    results.each do |result|
      new_specialty = Specialty.new(result)
      specialties << new_specialty
    end
  specialties
  end
end
