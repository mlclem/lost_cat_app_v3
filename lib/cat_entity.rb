class CatEntity
  def initialize(name, phone, description, password, sightings = [], id = nil)
    @name = name
    @phone = phone
    @description = description
    @sightings = sightings
    @password = password
    @id = id
  end

  def name
    return @name
  end

  def phone 
    return @phone
  end

  def description
    return @description
  end

  def password
    return @password
  end

  def sightings
    return @sightings
  end

  def id
    return @id
  end

end
