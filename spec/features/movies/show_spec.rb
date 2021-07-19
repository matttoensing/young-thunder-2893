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
#       Story 2
# Movie Show
#
# As a user,
# When I visit a movie's show page.
# I see the movie's title, creation year, and genre,
# and a list of all its actors from youngest to oldest.
# And I see the average age of all of the movie's actors

    end
  end
end
