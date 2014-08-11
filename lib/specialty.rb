class Specialty
  attr_reader :id, :name

  def initialize(attributes)
    @id = attributes['id'].to_i
    @name = attributes['name']
  end

  def ==(another_specialty)
    self.name == another_specialty.name && self.id == another_specialty.id
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

  def self.search_speciality(name)
    results = DB.exec("SELECT * FROM specialties WHERE name = '#{name}';")
    @id = results.first['id'].to_i
  end

  def self.update(name, id)
    DB.exec("UPDATE specialties SET name = '#{name}' WHERE id = #{id};")
    @name = name
  end
end
