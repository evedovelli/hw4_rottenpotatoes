class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.find_director_movies(director)
    movies = []
    if director and (director != "") then
      Movie.all.each do |movie|
        if movie.director == director then
          movies.push(movie)
        end
      end
    end
    return movies
  end

end
