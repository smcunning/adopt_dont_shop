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

describe 'as a visitor' do
  describe 'when I visit any page on the site' do
    it 'has a link at top of page that takes me to /pets' do
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

      visit '/shelters'
      expect(page).to have_link("Available Pets")
      click_on("Available Pets")
      expect(current_path).to eq("/pets")

      visit '/shelters/new'
      expect(page).to have_link("Available Pets")
      click_on("Available Pets")
      expect(current_path).to eq("/pets")

      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_link("Available Pets")
      click_on("Available Pets")
      expect(current_path).to eq("/pets")

      visit "/shelters/#{shelter_1.id}/edit"
      expect(page).to have_link("Available Pets")
      click_on("Available Pets")
      expect(current_path).to eq("/pets")

      visit "/shelters/#{shelter_1.id}/pets"
      expect(page).to have_link("Available Pets")
      click_on("Available Pets")
      expect(current_path).to eq("/pets")

      visit "/pets"
      expect(page).to have_link("Available Pets")
      click_on("Available Pets")
      expect(current_path).to eq("/pets")

      visit "/pets/#{pet_1.id}"
      expect(page).to have_link("Available Pets")
      click_on("Available Pets")
      expect(current_path).to eq("/pets")

      visit "/shelters/#{shelter_1.id}/pets/new"
      expect(page).to have_link("Available Pets")
      click_on("Available Pets")
      expect(current_path).to eq("/pets")

      visit "/pets/#{pet_1.id}/edit"
      expect(page).to have_link("Available Pets")
      click_on("Available Pets")
      expect(current_path).to eq("/pets")
    end
  end
end

describe 'as a visitor' do
  describe 'when I visit any page on the site' do
    it 'has a link at top of page that takes me to /shelters' do
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

      visit '/shelters'
      expect(page).to have_link("All Shelters")
      click_on("All Shelters")
      expect(current_path).to eq("/shelters")

      visit '/shelters/new'
      expect(page).to have_link("All Shelters")
      click_on("All Shelters")
      expect(current_path).to eq("/shelters")

      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_link("All Shelters")
      click_on("All Shelters")
      expect(current_path).to eq("/shelters")

      visit "/shelters/#{shelter_1.id}/edit"
      expect(page).to have_link("All Shelters")
      click_on("All Shelters")
      expect(current_path).to eq("/shelters")

      visit "/shelters/#{shelter_1.id}/pets"
      expect(page).to have_link("All Shelters")
      click_on("All Shelters")
      expect(current_path).to eq("/shelters")

      visit "/pets"
      expect(page).to have_link("All Shelters")
      click_on("All Shelters")
      expect(current_path).to eq("/shelters")

      visit "/pets/#{pet_1.id}"
      expect(page).to have_link("All Shelters")
      click_on("All Shelters")
      expect(current_path).to eq("/shelters")

      visit "/shelters/#{shelter_1.id}/pets/new"
      expect(page).to have_link("All Shelters")
      click_on("All Shelters")
      expect(current_path).to eq("/shelters")

      visit "/pets/#{pet_1.id}/edit"
      expect(page).to have_link("All Shelters")
      click_on("All Shelters")
      expect(current_path).to eq("/shelters")
    end
  end
end
