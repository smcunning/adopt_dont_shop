require 'rails_helper'
describe 'As a visitor' do
  describe 'when I visit /shelters' do
    it 'then I see the name of each shelter in the system' do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      shelter_2 = Shelter.create(name: 'Happy Home',
                                 address: '777 Gumball Rd',
                                 city: 'Bubblegumville',
                                 state: 'Colorado',
                                 zip: 67891)


    visit '/shelters'
    expect(page).to have_content("#{shelter_1.name}")
    expect(page).to have_content("#{shelter_2.name}")
    end
  end
end

describe 'As a visitor' do
  describe 'when I visit /shelters' do
    it 'has a link to create a new shelter "New Shelter"' do
      visit '/shelters'
    expect(page).to have_link("Add a Shelter")
    end
  end
end

describe 'As a visitor' do
  describe 'when I click the "Add a shelter" link' do
    it 'I am taken to /shelters/new where I see a form for a new shelter' do
      visit '/shelters'
      click_on 'Add a Shelter'
      expect(current_path).to eq("/shelters/new")
      expect(page).to have_field('shelter[name]')
      expect(page).to have_field('shelter[address]')
      expect(page).to have_field('shelter[city]')
      expect(page).to have_field('shelter[state]')
      expect(page).to have_field('shelter[zip]')
    end
  end
end

describe 'As a visitor' do
  describe 'when I visit the /shelters page' do
    it 'has a link to edit next to every shelters info' do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      shelter_2 = Shelter.create(name: 'Happy Home',
                                 address: '777 Gumball Rd',
                                 city: 'Bubblegumville',
                                 state: 'Colorado',
                                 zip: 67891)
      visit '/shelters'
      within("#shelter-review-#{shelter_1.id}") do
        expect(page).to have_link("Edit Info for #{shelter_1.name}")
        click_on("Edit Info for #{shelter_1.name}")
        expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
      end
      visit '/shelters'
      expect(page).to have_link("Edit Info for #{shelter_2.name}")
      click_on("Edit Info for #{shelter_2.name}")
      expect(current_path).to eq("/shelters/#{shelter_2.id}/edit")
    end
  end
end

describe 'As a visitor' do
  describe 'when I visit the /shelters page' do
    it 'has a link to delete next to every shelters info' do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      shelter_2 = Shelter.create(name: 'Happy Home',
                                 address: '777 Gumball Rd',
                                 city: 'Bubblegumville',
                                 state: 'Colorado',
                                 zip: 67891)
      visit '/shelters'

      within("#shelter-review-#{shelter_2.id}") do
        expect(page).to have_link("Delete #{shelter_2.name}")
        click_on("Delete #{shelter_2.name}")
      end
        expect(current_path).to eq("/shelters")
        expect(page).to have_no_content("Happy Home")
        expect(page).to have_content("Sunny Days Shelter")
    end
  end
end
