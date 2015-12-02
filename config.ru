require "pry"
require "sinatra"

require_relative "db/config"
require_relative "server"

run App::Server