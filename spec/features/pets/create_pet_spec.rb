require 'rails_helper'

describe 'Shelter Pet Creation' do
  describe 'on the shelter/:shelter_id/pets page, when I click the "Create Pet" link' do
    it 'I am taken to /shelters/:shelter_id/pets/new where I see a form for a new pet' do
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

      visit "/shelters/#{shelter_1.id}/pets"
      click_on "Create Pet"
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")
      expect(page).to have_field('image')
      expect(page).to have_field('name')
      expect(page).to have_field('description')
      expect(page).to have_field('approx_age')
      expect(page).to have_field('sex')
    end

    it 'can fill in fields and create a new pet' do
      visit "/shelters/#{shelter_1.id}/pets/new"

      fill_in :image, with: "https://i.ibb.co/0CMggpV/pet-3.jpg"
      fill_in :name, with: "Punkin"
      fill_in :description, with: "Cuddly and good with dogs!"
      fill_in :approx_age, with: 1
      fill_in :sex, with: "Male"
      click_button("Create Pet")

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
      expect(page).to have_content("Punkin")
      expect(page).to have_content("Cuddly and good with dogs!")
    end 
  end
end
