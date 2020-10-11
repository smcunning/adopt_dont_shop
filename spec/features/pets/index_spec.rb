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
      save_and_open_page
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
