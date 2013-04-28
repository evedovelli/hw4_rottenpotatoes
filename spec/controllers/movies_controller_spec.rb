require 'spec_helper'

describe MoviesController do

  describe 'show movies from a director' do
    before :each do
      @fake_movies = [ mock('Movie1'), mock('Movie2') ]
      @fake_movies[0].stub(:director).and_return('Quentin Tarantino')
      @fake_movies[0].stub(:title).and_return('Pulp Fiction')
      Movie.stub(:find).and_return(@fake_movies[0])
      Movie.stub(:find_director_movies).and_return(@fake_movies)
    end
    it 'should call the model method to list movies and find director from id' do
      Movie.should_receive(:find).with('1')
      get :director, { :id => 1 }
    end
    it 'should call the model method to list movies whose director matches the current one' do
      Movie.should_receive(:find_director_movies).with('Quentin Tarantino')
      get :director, { :id => 1 }
    end
    describe 'after valid list returned' do
      before :each do
        get :director, { :id => '1' }
      end
      it 'should select the Director template for rendering' do
        response.should render_template('director')
      end
      it 'should make the list of movies of the director available to that template' do
        assigns(:movies).should == @fake_movies
      end
    end
  end

  describe 'show movies from a director with no movies' do
    before :each do
      @fake_movies = [ mock('Movie1'), mock('Movie2') ]
      @fake_movies[0].stub(:director).and_return(nil)
      @fake_movies[0].stub(:title).and_return('Argo')
      Movie.stub(:find).and_return(@fake_movies[0])
      Movie.stub(:find_director_movies).and_return([])
    end
    it 'should call the model method to list movies from director without a director' do
      Movie.should_receive(:find_director_movies).with(nil)
      get :director, { :id => 1 }
    end
    it 'should select the Movies template for rendering' do
      get :director, { :id => 1 }
      response.should redirect_to('/movies')
    end
    it 'should make the message saying there is no director available to the template' do
      get :director, { :id => 1 }
      flash[:notice].should == "'Argo' has no director info"
    end
  end

end
