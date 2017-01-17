#require 'sqlite3'
require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "sqlite3:db/development.db")

#ActiveRecord::Base.configurations = YAML.load_file('db/database.yml')
#ActiveRecord::Base.establish_connection(:development)

class Keep < ActiveRecord::Base
end