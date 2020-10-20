require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit /pets' do
    it 'has a list of pets and their information' do
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
     pet_2 = Pet.create(image: 'https://i.ibb.co/jJK9jWN/pet-2.jpg',
                        name: 'Gigi',
                        approx_age: 4,
                        sex: 'Female',
                        description: 'Talkative and playful!',
                        adoptable: true,
                        shelter_id: shelter_1.id)
      visit '/pets'
      expect(page).to have_xpath("//img[contains(@src,'#{pet_1.image}')]")
      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_1.approx_age}")
      expect(page).to have_content("#{pet_1.sex}")
      expect(page).to have_content("#{pet_1.shelter_name}")

      expect(page).to have_xpath("//img[contains(@src,'#{pet_2.image}')]")
      expect(page).to have_content("#{pet_2.name}")
      expect(page).to have_content("#{pet_2.approx_age}")
      expect(page).to have_content("#{pet_2.sex}")
      expect(page).to have_content("#{pet_2.shelter_name}")
    end
  end
end

describe 'As a visitor' do
  describe 'when I visit the /pets or /shelter/:id/pets page' do
    it 'has a link to edit next to every pets info' do
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
     pet_2 = Pet.create(image: 'https://i.ibb.co/jJK9jWN/pet-2.jpg',
                        name: 'Gigi',
                        approx_age: 4,
                        sex: 'Female',
                        description: 'Talkative and playful!',
                        adoptable: true,
                        shelter_id: shelter_1.id)
      visit '/pets'
      expect(page).to have_link("Edit Info for #{pet_1.name}")
      click_on("Edit Info for #{pet_1.name}")
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      visit "/shelters/#{shelter_1.id}/pets"
      expect(page).to have_link("Edit Info for #{pet_2.name}")
      click_on("Edit Info for #{pet_2.name}")
      expect(current_path).to eq("/pets/#{pet_2.id}/edit")
    end
  end
end

describe 'As a visitor' do
  describe 'when I visit the /pets or /shelter/:id/pets page' do
    it 'has a link to delete next to every pets info' do
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
                        shelter_id: "#{shelter_1.id}")
     pet_2 = Pet.create(image: 'https://i.ibb.co/jJK9jWN/pet-2.jpg',
                        name: 'Gigi',
                        approx_age: 4,
                        sex: 'Female',
                        description: 'Talkative and playful!',
                        adoptable: true,
                        shelter_id: "#{shelter_1.id}")
      visit '/pets'
      expect(page).to have_link("Delete #{pet_1.name}")
      click_on("Delete #{pet_1.name}")
      expect(current_path).to eq("/pets")
      expect(page).to have_no_content("Skye")
      expect(page).to have_content("Gigi")

      visit "/shelters/#{shelter_1.id}/pets"
      expect(page).to have_link("Delete #{pet_2.name}")
      click_on("Delete #{pet_2.name}")
      expect(current_path).to eq("/pets")
      expect(page).to have_no_content("Gigi")
    end
  end
end

describe 'as a visitor' do
  describe 'the pet index page has a link to Start an Application' do
    it 'takes me to /applications/new' do
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
                        shelter_id: "#{shelter_1.id}")
     pet_2 = Pet.create(image: 'https://i.ibb.co/jJK9jWN/pet-2.jpg',
                        name: 'Gigi',
                        approx_age: 4,
                        sex: 'Female',
                        description: 'Talkative and playful!',
                        adoptable: true,
                        shelter_id: "#{shelter_1.id}")


      visit '/pets'

      expect(page).to have_link("Start an Application")
      click_link("Start an Application")
      expect(current_path).to eq('/applications/new')
    end
  end
end

describe "As a visior" do
  describe "if a pet has an approved application" do
    it "Cannot be deleted" do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      user = User.create!(name: "Betty",
                          address: "123 Main st",
                          city: "Denver",
                          state: "CO",
                          zip: 80111)
      pet_1 = Pet.create(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                         name: 'Skye',
                         approx_age: 3,
                         sex: 'Female',
                         shelter_id: shelter_1.id)
      application = Application.create!(description: "I will take great care of Skye",
                                        status: "Approved",
                                        user_id: user.id)
      pet_application = PetApplication.create!(pet_id: pet_1.id,
                                               user_id: user.id,
                                               application_id: application.id)

      visit "/pets/"

      click_link("Delete #{pet_1.name}")
      expect(page).to have_content("Cannot delete pet with an approved application.")
    end

    it "CAN be deleted" do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      user = User.create!(name: "Betty",
                          address: "123 Main st",
                          city: "Denver",
                          state: "CO",
                          zip: 80111)
      pet_1 = Pet.create(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                         name: 'Skye',
                         approx_age: 3,
                         sex: 'Female',
                         shelter_id: shelter_1.id)
      application = Application.create!(description: "I will take great care of Skye",
                                        status: "In Progress",
                                        user_id: user.id)
      pet_application = PetApplication.create!(pet_id: pet_1.id,
                                               user_id: user.id,
                                               application_id: application.id)

      visit "/pets/"

      click_link("Delete #{pet_1.name}")
      expect(current_path).to eq("/pets")
      expect(page).to_not have_content("#{pet_1.name}")
    end
  end
end
