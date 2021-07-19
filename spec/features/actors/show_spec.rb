require 'rails_helper'

RSpec.describe 'actor show page' do
  describe 'displays actor info' do
    it 'user can visit an actors show page to see actors name and age' do
      actor = Actor.create!(name: "John Cusack", age: 53)

      visit "/actors/#{actor.id}"

      expect(page).to have_content("Actor Information")
      expect(page).to have_content("Actor's Name: #{actor.name}")
      expect(page).to have_content("Actor's Age: #{actor.age}")
    end
  end

  describe 'actor coactors' do
    it 'displays a list of all other actors the actor has worked with' do
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
      movie1.movie_actors.create!(actor: actor7)
      movie2.movie_actors.create!(actor: actor1)
      movie2.movie_actors.create!(actor: actor4)
      movie2.movie_actors.create!(actor: actor5)
      movie2.movie_actors.create!(actor: actor6)

      visit "/actors/#{actor1.id}"

      expect(page).to have_content("Other Actors #{actor1.name} has Worked With:")
      expect(page).to have_content("Robert Downy, JR")
      expect(page).to have_content("Chris Evans")
      expect(page).to have_content("Samuel L Jackson")
      expect(page).to have_content("Scarlett Johansson")
      expect(page).to have_content("Joan Cusack")
      expect(page).to have_content("Jack Black")

#       Coactors
#
# As a user,
# When I visit an actor's show page
# I see that actors name and age
# And I see a unique list of all of the actors this particular actor has worked with.

    end
  end
end
