require "mysql2"
require_relative "../models/item"
require_relative "../models/category"

def create_db_client
  client = Mysql2::Client.new(
    :host => "localhost",
    :username => "root",
    :password => "password",
    :database => ENV["DB_NAME"],
  )

  client
end