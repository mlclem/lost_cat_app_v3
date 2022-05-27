require "sighting_entity"

class SightingssTable
  def initialize(db)
    @db = db
  end

  def list
    return @db.run("SELECT * FROM sightings_table ORDER BY id;").map do |row|
      row_to_object(row)
    end
  end

  def add(sighting)
    result = @db.run(
      "INSERT INTO sightings_table contents, date VALUES $1 RETURNING id;", [sighting.contents])
    return result[0]["id"]
  end

  private

  def row_to_object(row)
    return sighting_entity.new(
      row["contents"],
      row["id"]
    )
  end
end
