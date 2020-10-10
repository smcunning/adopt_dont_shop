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
