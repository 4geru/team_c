def rand_genre
	genres = Genre.all
	genres[rand(Genre.all.count-1)]
end