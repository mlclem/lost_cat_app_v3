require "cat_entity"

class CatsTable
  def initialize(db)
    @db = db
  end

  def list
    return @db.run("SELECT * FROM cats_table ORDER BY id;").map do |row|
      row_to_object(row)
    end
  end

  def add(cat)
    result = @db.run(
      "INSERT INTO cats_table (name, phone, description, password)
      VALUES ($1, $2, $3, $4) RETURNING id;", 
      [cat.name, cat.phone, cat.description, cat.password]
    )
    return result[0]["id"]
  end

  def remove(index)
    @db.run("DELETE FROM cats_table WHERE id = $1;", [index])
  end

  def update(index, new_cat)
    @db.run(
      "UPDATE cats_table SET name =$1, phone = $2, description = $3, 
      password =$4 WHERE id = $5;", 
      [new_cat.name, new_cat.phone, new_cat.description, new_cat.password, index]
    )
  end

  def get(index)
    result = @db.run("SELECT * FROM cats_table WHERE id = $1;", [index])
    return row_to_object(result[0])
  end

  private

  def row_to_object(row)
    return CatEntity.new(
      row["name"],
      row["phone"],
      row["description"],
      row["password"],
      row["id"]
    )
  end
end
