require 'rails_helper'
describe 'As a visitor' do
  describe 'when I visit /shelters/:id' do
    it 'then I see the shelter with that id and all its info' do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)

    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_content("#{shelter_1.name}")
    expect(page).to have_content("#{shelter_1.address}")
    expect(page).to have_content("#{shelter_1.city}")
    expect(page).to have_content("#{shelter_1.state}")
    expect(page).to have_content("#{shelter_1.zip}")
    end
  end
end

describe 'As a visitor' do
  describe 'when I visit /shelters/:id' do
    it 'has a link to delete shelter and the shelter is deleted when I click' do
    shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                               address: '1234 Happy Lane',
                               city: 'Hopscotch Town',
                               state: 'Colorado',
                               zip: 12345)

    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_link("Delete Shelter")
    click_on("Delete Shelter")
    save_and_open_page
    expect(current_path).to eq("/shelters")
    expect(page).to have_no_content("#{shelter_1.name}")
    end
  end
end
