class Insurance

attr_reader :id, :name

  def initialize(attributes)
    @id = attributes['id'].to_i
    @name = attributes['name']
  end

  def ==(another_insurance)
    self.name == another_insurance.name && self.id == another_insurance.id
  end

  def save
    results = DB.exec("INSERT INTO insurance (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM insurance;")
    insurance = []
    results.each do |result|
      new_insurance = Insurance.new(result)
      insurance << new_insurance
    end
  insurance
  end

  def self.search_insurance(name)
    results = DB.exec("SELECT * FROM insurance WHERE name = '#{name}';")
    @id = results.first['id'].to_i
  end

  def self.update(name, id)
    DB.exec("UPDATE insurance SET name = '#{name}' WHERE id = #{id};")
    @name = name
  end
end
