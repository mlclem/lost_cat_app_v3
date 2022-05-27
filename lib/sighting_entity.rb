require 'time'

class SightingEntity
  def initialize(contents, time = Time.new, id = nil)
    @contents = contents
    @time = time
    @id = id
  end

  def contents
    return @contents
  end

  def time
    return @time
  end

  def id
    return @id
  end
end
