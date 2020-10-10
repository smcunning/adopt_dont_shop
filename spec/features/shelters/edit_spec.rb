require 'rails_helper'

describe 'As a visitor' do
  describe 'I visit the shelter show page' do
    it 'has a link to update the shelter "Update Shelter" where I can fill out form' do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_link("Update Shelter")
      click_on("Update Shelter")
      expect(current_path).to eq("/shelters/#{shelter.id}/edit")
      expect(page).to have_field('shelter[name]')
      expect(page).to have_field('shelter[address]')
      expect(page).to have_field('shelter[city]')
      expect(page).to have_field('shelter[state]')
      expect(page).to have_field('shelter[zip]')
    end

    it 'can fill out the form and the shelters info is updated, then redirect to /shelter/shelter.id' do
      fill_in "shelter[name]", with: "Pretty Puppy Rescue"
      fill_in "shelter[address]", with: "1234 Awesome Rd."
      fill_in "shelter[city]", with: "Best Town"
      fill_in "shelter[state]", with: "Colorado"
      fill_in "shelter[zip]", with: 12345
      click_button "Submit"
      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("Pretty Puppy Rescue")
      expect(page).to have_no_content("Sunny Days Shelter")
    end
  end
end
