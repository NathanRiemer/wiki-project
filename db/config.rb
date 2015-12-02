require "active_record"

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/database.sqlite3'
)

Dir.glob("models/*.rb").each { |path| require_relative "../#{path}"}