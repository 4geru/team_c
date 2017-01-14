require './models/genre.rb'

def rand_genre
	genres = Genre.all
	genres[rand(Genre.all.count-1)].name
end