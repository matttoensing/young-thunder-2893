require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'relationships' do
    it { should belong_to(:studio) }
    it { should have_many :movie_actors }
    it { should have_many(:actors).through(:movie_actors) }
  end

  describe 'instance methods' do
    describe '#order_actors_by_age' do
      it 'can order movie actors by age in ascension' do
        studio = Studio.create!(name: "Marvel Studios", location: "Hollywood, CA")
        movie = studio.movies.create!(title: "Avengers", creation_year: 2011, genre: "SuperHero")
        actor1 = Actor.create!(name: "Robert Downy, JR", age: 42)
        actor2 = Actor.create!(name: "Chris Evans", age: 32)
        actor3 = Actor.create!(name: "Samuel L Jackson", age: 64)
        actor4 = Actor.create!(name: "Scarlett Johansson", age: 36)
        movie.movie_actors.create!(actor: actor1)
        movie.movie_actors.create!(actor: actor2)
        movie.movie_actors.create!(actor: actor3)

        expected = [actor2, actor1, actor3]

        expect(studio.order_actors_by_age).to eq(expected)
      end
    end
  end
end
