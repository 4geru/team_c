ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")
namespace :rand do

  desc "It make Genre db"
	task :genre do
		genres = Genre.all
		puts genres[rand(Genre.all.count-1)].name
	end
end