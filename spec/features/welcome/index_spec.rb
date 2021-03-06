require 'rails_helper'
describe 'As a user' do
  describe ' when I visit the root page' do
    it 'the user sees the landing page with links to shelters' do

      visit '/'

      expect(page).to have_content("Adopt, Don't Shop!")
      expect(page).to have_link("Shelters")
    end
  end
end
