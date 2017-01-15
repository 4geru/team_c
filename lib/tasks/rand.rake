require './models/genre.rb'
namespace :rand do

  desc "ランダムでジャンルを取ってくる"
	task :genre do
		genres = Genre.all
		puts genres[rand(Genre.all.count-1)].name
	end
end