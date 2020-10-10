require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit /pets' do
    it 'has a list of pets and their information' do
      pet_1 = Pet.create(image: 'https://ibb.co/NLFhYVD',
                         name: 'Skye',
                         approx_age: 3,
                         sex: 'Female',
                         shelter_name: 'Sunny Days Shelter')
     pet_2 = Pet.create(image: 'https://ibb.co/sWSpX6f',
                        name: 'Gigi',
                        approx_age: 4,
                        sex: 'Female',
                        shelter_name: 'Happy Home')
      visit '/pets'
      expect(page).to have_xpath("//image[contains(@src, '#{pet_1.image}')]")
      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_1.approx_age}")
      expect(page).to have_content("#{pet_1.sex}")
      expect(page).to have_content("#{pet_1.shelter_name}")

      expect(page).to have_xpath("//image[contains(@src, '#{pet_2.image}')]")
      expect(page).to have_content("#{pet_2.name}")
      expect(page).to have_content("#{pet_2.approx_age}")
      expect(page).to have_content("#{pet_2.sex}")
      expect(page).to have_content("#{pet_2.shelter_name}")
    end
  end
end
