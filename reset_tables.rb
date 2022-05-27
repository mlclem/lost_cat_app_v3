$:.unshift File.join(File.dirname(__FILE__), 'lib')
require "database_connection"

# This file sets up the database tables. If you change any of the contents
# of this file, you should rerun `ruby reset_tables.rb` to ensure that your
# database tables are re-created.

def reset_tables(db)
  db.run("DROP TABLE IF EXISTS animals;")
  db.run("CREATE TABLE animals (id SERIAL PRIMARY KEY, species TEXT NOT NULL);")
  
  # Add your table creation SQL here
  # Each one should be a pair of lines:
  db.run("DROP TABLE IF EXISTS cats_table;")
  db.run(
    "CREATE TABLE cats_table (id SERIAL PRIMARY KEY, name TEXT NOT NULL,
    phone TEXT NOT NULL, description TEXT NOT NULL, password TEXT NOT NULL);"
  )
  db.run("DROP TABLE IF EXISTS sightings_table;")
  db.run("CREATE TABLE sightings_table (id SERIAL PRIMARY KEY, contents TEXT NOT NULL, ")
end

dev_db = DatabaseConnection.new("localhost", "web_application_dev")
reset_tables(dev_db)

test_db = DatabaseConnection.new("localhost", "web_application_test")
reset_tables(test_db)
