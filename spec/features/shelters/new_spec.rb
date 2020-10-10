require 'rails_helper'
describe 'when I fill out the form with a new shelters information' do
  describe 'and I click the button "Create Shelter" to submit the form' do
    it 'posts to /shelters, new shelter is created and Im redirected to /shelters with new shelter listed' do
      visit '/shelters/new'
      fill_in "shelter[name]", with: "Pretty Puppy Rescue"
      fill_in "shelter[address]", with: "1234 Awesome Rd."
      fill_in "shelter[city]", with: "Best Town"
      fill_in "shelter[state]", with: "Colorado"
      fill_in "shelter[zip]", with: 12345
      click_button "Create Shelter"
      expect(page).to have_content("Pretty Puppy Rescue")
    end
  end
end
