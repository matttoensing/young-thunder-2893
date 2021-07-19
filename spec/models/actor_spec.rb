require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe 'relationships' do
    it { should have_many :movie_actors }
    it { should have_many(:movies).through(:movie_actors) }
  end

  describe 'instance methods' do
    describe '#coactors' do
      it 'can show other actors that are connected to actor' do
        actor1 = Actor.create!(name: "John Cusack", age: 53)
        studio = Studio.create!(name: "Marvel Studios", location: "Hollywood, CA")
        movie1 = studio.movies.create!(title: "Avengers", creation_year: 2011, genre: "SuperHero")
        movie2 = studio.movies.create!(title: "Infinity Wars", creation_year: 2011, genre: "SuperHero")
        actor2 = Actor.create!(name: "Robert Downy, JR", age: 42)
        actor3 = Actor.create!(name: "Chris Evans", age: 32)
        actor4 = Actor.create!(name: "Samuel L Jackson", age: 64)
        actor5 = Actor.create!(name: "Scarlett Johansson", age: 36)
        actor6 = Actor.create!(name: "Joan Cusack", age: 36)
        actor7 = Actor.create!(name: "Jack Black", age: 36)
        movie1.movie_actors.create!(actor: actor1)
        movie1.movie_actors.create!(actor: actor2)
        movie1.movie_actors.create!(actor: actor3)
        movie2.movie_actors.create!(actor: actor1)
        movie2.movie_actors.create!(actor: actor4)
        movie2.movie_actors.create!(actor: actor5)
        movie2.movie_actors.create!(actor: actor6)

        expected = [actor2, actor3, actor4, actor5, actor6]
        
        expect(actor1.coactors).to eq(expected)
        expect(Actor.coactors(actor1.id)).to eq(expected)
        expect(actor1.coactors).to eq(expected)
      end
    end
  end
end
