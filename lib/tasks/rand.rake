require './models/genre.rb'
namespace :rand do

  desc "It make Genre db"
	task :genre do
		genres = Genre.all
		puts genres[rand(Genre.all.count-1)].name
	end
end