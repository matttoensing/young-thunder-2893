require 'rails_helper'

RSpec.describe 'studio index page' do
  describe 'page content' do
    it 'displays each studio name and location' do
      studio1 = Studio.create!(name: "Marvel Studios", location: "Hollywood, CA")
      studio2 = Studio.create!(name: "Univeral Studios", location: "Santa Monica, CA")

      visit '/studios'

      expect(page).to have_content("Studio Name: #{studio1.name}")
      expect(page).to have_content("Studio Location: #{studio1.location}")
      expect(page).to have_content("Studio Name: #{studio2.name}")
      expect(page).to have_content("Studio Location: #{studio2.location}")
#       Story 1
# Studio Index
#
# As a user,
# When I visit the studio index page
# I see a each studio's name and location
# And underneath each studio, I see the titles of all of its movies.

    end
  end
end
