class Insurance

attr_reader :id, :name

  def initialize(attributes)
    @id = attributes['id']
    @name = attributes['name']
  end

  def ==(another_insurance)
    self.name == another_insurance.name
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



end
