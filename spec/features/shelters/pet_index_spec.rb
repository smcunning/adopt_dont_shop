require 'rails_helper'
describe 'As a visitor' do
  describe 'when I visit /shelters/:shelter_id/pets' do
    it 'shows all pets that can be adopted from that shelter' do
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
    pet_1 = Pet.create(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                       name: 'Skye',
                       approx_age: 3,
                       sex: 'Female',
                       shelter_id: shelter_1.id)
    pet_2 = Pet.create(image: 'https://i.ibb.co/jJK9jWN/pet-2.jpg',
                      name: 'Gigi',
                      approx_age: 4,
                      sex: 'Female',
                      shelter_id: shelter_2.id)

    visit "/shelters/#{shelter_1.id}/pets"
    save_and_open_page
    # expect(page).to have_xpath("//img[contains(@src,'#{pet_1.image}')]")
    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_content("#{pet_1.approx_age}")
    expect(page).to have_content("#{pet_1.sex}")
    expect(page).to have_no_content("#{pet_2.name}")

    visit "/shelters/#{shelter_2.id}/pets"
    # expect(page).to have_xpath("//img[contains(@src,'#{pet_2.image}')]")
    expect(page).to have_content("#{pet_2.name}")
    expect(page).to have_content("#{pet_2.approx_age}")
    expect(page).to have_content("#{pet_2.sex}")
    expect(page).to have_no_content("#{pet_1.name}")
    end
  end
end
