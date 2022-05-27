require "helpers/database_helpers"
require "sighting_entity"
require "sightings_table"

RSpec.describe SightingsTable do
  def clean_and_get_database
    DatabaseHelpers.clear_table("cats_table")
    return DatabaseHelpers.test_db_connection
  end

  it "start with an empty table" do
    db = clean_and_get_database
    cats_table = CatsTable.new(db)
    expect(cats_table.list).to eq([])
  end

  it "adds cats and lists them out again" do
    db = clean_and_get_database
    cats_table = CatsTable.new(db)
    cats_table.add(
      CatEntity.new(
      "Cat", 
      "01981 498 478", 
      "kitty cat catto", 
      "passthecat")
    )

    cats = cats_table.list
    expect(cats.length).to eq 1
    expect(cats[0].name).to eq "Cat"
    expect(cats[0].phone).to eq "01981 498 478"
    expect(cats[0].description).to eq "kitty cat catto"
    expect(cats[0].password).to eq "passthecat"
  end

  it "removes cats" do
    db = clean_and_get_database
    cats_table = CatsTable.new(db)

    red_cat_id = cats_table.add(CatEntity.new("Red","1029410293", "Red cat", "redpass"))
    blue_cat_id = cats_table.add(CatEntity.new("Blue", "08317018750","Blue cat", "bluepass"))
    green_cat_id = cats_table.add(CatEntity.new("Green","03875023850", "Green cat", "greenpass"))

    cats_table.remove(blue_cat_id)

    cats = cats_table.list
    expect(cats.length).to eq 2
    expect(cats[0].name).to eq "Red"
    expect(cats[0].phone).to eq "1029410293"
    expect(cats[0].description).to eq "Red cat"
    expect(cats[0].password).to eq "redpass"
    expect(cats[1].name).to eq "Green"
    expect(cats[1].phone).to eq "03875023850"
    expect(cats[1].description).to eq "Green cat"
    expect(cats[1].password).to eq "greenpass"
  end

  it "updates cats" do
    db = clean_and_get_database
    cats_table = CatsTable.new(db)

    red_cat_id = cats_table.add(CatEntity.new("Red","1029410293", "Red cat", "redpass"))
    blue_cat_id = cats_table.add(CatEntity.new("Blue", "08317018750","Blue cat", "bluepass"))
    green_cat_id = cats_table.add(CatEntity.new("Green","03875023850", "Green cat", "greenpass"))
  
    orange_cat = CatEntity.new("Orange","03030 808 909", "Orange cat", "orangepass")
    cats_table.update(green_cat_id, orange_cat)

    cats = cats_table.list
    expect(cats.length).to eq 3
    expect(cats[0].name).to eq "Red"
    expect(cats[0].phone).to eq "1029410293"
    expect(cats[0].description).to eq "Red cat"
    expect(cats[0].password).to eq "redpass"
    expect(cats[1].name).to eq "Blue"
    expect(cats[1].phone).to eq "08317018750"
    expect(cats[1].description).to eq "Blue cat"
    expect(cats[1].password).to eq "bluepass"
    expect(cats[2].name).to eq "Orange"
    expect(cats[2].phone).to eq "03030 808 909"
    expect(cats[2].description).to eq "Orange cat"
    expect(cats[2].password).to eq "orangepass"
  end

  context "if cats have been added" do
    it "a single cat instance can be returned" do
      db = clean_and_get_database
      cats_table = CatsTable.new(db)
      cats_table.add(CatEntity.new(
        "Cat", 
        "01981 498 478", 
        "kitty cat catto", 
        "passthecat")
      )
      cats_table.add(CatEntity.new(
        "Newer cat", 
        "01982 498 478", 
        "kitty cat catto the 32nd", 
        "neuecatneue")
      )
      result1 = cats_table.get(1)
      expect(result1.name).to eq "Cat"
      expect(result1.phone).to eq "01981 498 478" 
      expect(result1.description).to eq "kitty cat catto"
      expect(result1.password).to eq "passthecat" 
      result2 = cats_table.get(2)
      expect(result2.name).to eq "Newer cat"
      expect(result2.phone).to eq "01982 498 478" 
      expect(result2.description).to eq "kitty cat catto the 32nd"
      expect(result2.password).to eq "neuecatneue" 
    end  
  end
end
