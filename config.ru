require "pry"
require "sinatra"
require "redcarpet"

require_relative "link_utils"
require_relative "db/config"
require_relative "server"

run App::Server