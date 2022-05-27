require "database_connection"

class DatabaseHelpers
  def self.clear_table(table_name)
    test_db_connection.run("DELETE FROM #{table_name};")
    test_db_connection.run("ALTER SEQUENCE cats_table_id_seq RESTART WITH 1;")
    test_db_connection.run("ALTER SEQUENCE sightings_table_id_seq RESTART WITH 1;")
  end

  def self.test_db_connection
    $test_connection ||= DatabaseConnection.new("localhost", "web_application_test")
  end
end
