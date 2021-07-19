require 'rails_helper'

RSpec.describe 'movie show page' do
  describe 'displays content on page' do
    it 'shows movie title, creation year, and genre' do
      studio = Studio.create!(name: "Marvel Studios", location: "Hollywood, CA")
      movie = studio.movies.create!(title: "Avengers", creation_year: 2011, genre: "SuperHero")


      visit "/movies/#{movie.id}"

      expect(page).to have_content("Movie Title: #{movie.title}")
      expect(page).to have_content("Year of Production: #{movie.creation_year}")
      expect(page).to have_content("Genre: #{movie.genre}")
    end

    it "shows a list of the movie's actors from youngest to oldest" do
      studio = Studio.create!(name: "Marvel Studios", location: "Hollywood, CA")
      movie = studio.movies.create!(title: "Avengers", creation_year: 2011, genre: "SuperHero")
      actor1 = Actor.create!(name: "Robert Downy, JR", age: 42)
      actor2 = Actor.create!(name: "Chris Evans", age: 32)
      actor3 = Actor.create!(name: "Samuel L Jackson", age: 64)
      actor4 = Actor.create!(name: "Scarlett Johansson", age: 36)
      movie.movie_actors.create!(actor: actor1)
      movie.movie_actors.create!(actor: actor2)
      movie.movie_actors.create!(actor: actor3)

      visit "/movies/#{movie.id}"
      
      expect(actor2.name).to appear_before(actor1.name)
      expect(actor1.name).to appear_before(actor3.name)
      expect(page).to_not have_content("Scarlett Johansson")
      #       Story 2
      # Movie Show
      #
      # As a user,
      # When I visit a movie's show page.
      # I see the movie's title, creation year, and genre,
      # and a list of all its actors from youngest to oldest.
      # And I see the average age of all of the movie's actors
    end

    it "displays the movie's actors average age" do
      studio = Studio.create!(name: "Marvel Studios", location: "Hollywood, CA")
      movie = studio.movies.create!(title: "Avengers", creation_year: 2011, genre: "SuperHero")
      actor1 = Actor.create!(name: "Robert Downy, JR", age: 42)
      actor2 = Actor.create!(name: "Chris Evans", age: 32)
      actor3 = Actor.create!(name: "Samuel L Jackson", age: 64)
      actor4 = Actor.create!(name: "Scarlett Johansson", age: 36)
      movie.movie_actors.create!(actor: actor1)
      movie.movie_actors.create!(actor: actor2)
      movie.movie_actors.create!(actor: actor3)

      visit "/movies/#{movie.id}"

      expect(page).to have_content("Average Age of Actors: #{movie.average_age_of_actors}")
    end
  end
end
