require 'rails_helper'

describe 'as a visitor' do
  describe 'when I click on the name of a shelter anywhere on the site' do
    it 'takes me to the shelters/:id page' do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      visit '/shelters'
      expect(page).to have_link("#{shelter_1.name}")
      click_on("#{shelter_1.name}")
      expect(current_path).to eq("/shelters/#{shelter_1.id}")

      visit "/shelters/#{shelter_1.id}/pets"
      expect(page).to have_link("#{shelter_1.name}")
      click_on("#{shelter_1.name}")
      expect(current_path).to eq("/shelters/#{shelter_1.id}")
    end
  end
end

describe 'as a visitor' do
  describe 'when I click on the name of a pet anywhere on the site' do
    it 'takes me to the pets/:id page' do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      pet_1 = Pet.create(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                        name: 'Skye',
                        approx_age: 3,
                        sex: 'Female',
                        description: 'Shy and loveable!',
                        adoptable: true,
                        shelter_id: shelter_1.id)
      visit '/pets'
      expect(page).to have_link("#{pet_1.name}")
      click_on("#{pet_1.name}")
      expect(current_path).to eq("/pets/#{pet_1.id}")

      visit "/shelters/#{shelter_1.id}/pets"
      expect(page).to have_link("#{pet_1.name}")
      click_on("#{pet_1.name}")
      expect(current_path).to eq("/pets/#{pet_1.id}")
    end
  end
end
