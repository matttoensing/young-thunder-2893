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

    it 'does not list actors that are not in the movie' do
      studio = Studio.create!(name: "Marvel Studios", location: "Hollywood, CA")
      movie = studio.movies.create!(title: "Avengers", creation_year: 2011, genre: "SuperHero")
      actor1 = Actor.create!(name: "Robert Downy, JR", age: 42)
      actor2 = Actor.create!(name: "Chris Evans", age: 32)
      actor3 = Actor.create!(name: "Samuel L Jackson", age: 64)
      actor4 = Actor.create!(name: "Harrison Ford", age: 72)
      movie.movie_actors.create!(actor: actor1)
      movie.movie_actors.create!(actor: actor2)
      movie.movie_actors.create!(actor: actor3)

      visit "/movies/#{movie.id}"

      expect(page).to_not have_content("Harrison Ford")
    end
  end

  describe 'form for adding actors' do
    it 'user sees a form to add movie to page with a submit button' do
      studio = Studio.create!(name: "Marvel Studios", location: "Hollywood, CA")
      movie = studio.movies.create!(title: "Avengers", creation_year: 2011, genre: "SuperHero")
      actor1 = Actor.create!(name: "Robert Downy, JR", age: 42)
      actor2 = Actor.create!(name: "Chris Evans", age: 32)
      actor3 = Actor.create!(name: "Samuel L Jackson", age: 64)
      movie.movie_actors.create!(actor: actor1)
      movie.movie_actors.create!(actor: actor2)
      movie.movie_actors.create!(actor: actor3)

      visit "/movies/#{movie.id}"

      expect(page).to have_content("Add Actor to Movie")

      fill_in 'name', with: "Scarlett Johansson"
      fill_in 'age', with: 36

      expect(page).to have_button("Submit")
    end

    it 'user fills out form and clicks submit to be redirected back to movie show page with actor info listed on page' do
      studio = Studio.create!(name: "Marvel Studios", location: "Hollywood, CA")
      movie = studio.movies.create!(title: "Avengers", creation_year: 2011, genre: "SuperHero")
      actor1 = Actor.create!(name: "Robert Downy, JR", age: 42)
      actor2 = Actor.create!(name: "Chris Evans", age: 32)
      actor3 = Actor.create!(name: "Samuel L Jackson", age: 64)
      movie.movie_actors.create!(actor: actor1)
      movie.movie_actors.create!(actor: actor2)
      movie.movie_actors.create!(actor: actor3)

      visit "/movies/#{movie.id}"

      expect(page).to have_content("Add Actor to Movie")

      fill_in 'name', with: "Scarlett Johansson"
      fill_in 'age', with: 36
      click_on 'Submit'

      expect(current_path).to eq("/movies/#{movie.id}")
      expect(page).to have_content("Scarlett Johansson")
      expect("Scarlett Johansson").to appear_before(actor1.name)
      expect(page).to have_content("36")
    end
  end
end
