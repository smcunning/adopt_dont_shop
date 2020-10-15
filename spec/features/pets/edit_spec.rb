require 'rails_helper'

describe 'visit /pets/:id' do

  describe 'click link to update pet and redirect to pets/:id/edit' do
    it 'has a form to edit pets data' do
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

      visit "/pets/#{pet_1.id}"
      click_on("Update Pet")
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")
      expect(page).to have_field('image')
      expect(page).to have_field('name')
      expect(page).to have_field('description')
      expect(page).to have_field('approx_age')
      expect(page).to have_field('sex')
    end

    it 'updates all pet data and redirects to /pet/:id when click Update Pet button' do
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

      visit "/pets/#{pet_1.id}/edit"

      fill_in :image, with: "https://i.ibb.co/0CMggpV/pet-3.jpg"
      fill_in :name, with: "Punkin"
      fill_in :description, with: "Cuddly and good with dogs!"
      fill_in :approx_age, with: 1
      fill_in :sex, with: "Male"
      click_on("Update Pet")

      expect(current_path).to eq("/pets/#{pet_1.id}")
      expect(page).to have_xpath("//img[contains(@src,'https://i.ibb.co/0CMggpV/pet-3.jpg')]")
      expect(page).to have_content("Punkin")
      expect(page).to have_content(1)
      expect(page).to have_content("Male")
    end

    it 'updates some pet data and redirects to /pet/:id when click Update Pet button' do
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

      visit "/pets/#{pet_1.id}/edit"
      fill_in :image, with: "https://i.ibb.co/0CMggpV/pet-3.jpg"
      fill_in :name, with: "Punkin"
      fill_in :approx_age, with: 1
      fill_in :sex, with: "Male"
      click_button("Update Pet")
      expect(current_path).to eq("/pets/#{pet_1.id}")
      expect(page).to have_xpath("//img[contains(@src,'https://i.ibb.co/0CMggpV/pet-3.jpg')]")
      expect(page).to have_content("Punkin")
      expect(page).to have_content('Shy and loveable!')
      expect(page).to have_content(1)
      expect(page).to have_content("Male")
    end
  end
end
