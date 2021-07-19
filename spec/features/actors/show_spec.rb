require 'rails_helper'

RSpec.describe 'actor show page' do
  describe 'displays actor info' do
    it 'user can visit an actors show page to see actors name and age' do
      actor = Actor.create!(name: "John Cusack", age: 53)

      visit "/actors/#{actor.id}"

      expect(page).to have_content("Actor Information")
      expect(page).to have_content("Actor's Name: #{actor.name}")
      expect(page).to have_content("Actor's Age: #{actor.age}")
#   Coactors
#
# As a user,
# When I visit an actor's show page
# I see that actors name and age
# And I see a unique list of all of the actors this particular actor has worked with.
    end
  end
end
