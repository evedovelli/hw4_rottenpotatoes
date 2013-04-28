require 'spec_helper'

describe Movie do
  describe 'find all movies from an existing director' do
    before :each do
      Movie.create({:director => 'Tim Burton'})
      Movie.create({:director => 'Tim Farris'})
      Movie.create({:director => 'Tim Burton'})
    end
    it 'should return a list with all movies from an director with more than one movie' do
      movies = Movie.find_director_movies('Tim Burton')
      movies.length.should == 2
      movies[0].director.should == 'Tim Burton'
      movies[1].director.should == 'Tim Burton'
    end
    it 'should return a list with all movies from an director with one movie' do
      movies = Movie.find_director_movies('Tim Farris')
      movies.length.should == 1
      movies[0].director.should == 'Tim Farris'
    end
    it 'should return an empty list when director has no movies' do
      movies = Movie.find_director_movies('Tim Tim')
      movies.length.should == 0
    end
  end
end

