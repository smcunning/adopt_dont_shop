require 'rails_helper'
describe 'Pet Show' do
  describe 'when I visit /pets/:id' do
      it 'shows the pet with that id' do

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
                      adoptable: true)


    visit "/pets/#{pet_1.id}"

    expect(page).to have_xpath("//img[contains(@src,'#{pet_1.image}')]")
    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_content("#{pet_1.approx_age}")
    expect(page).to have_content("#{pet_1.sex}")
    expect(page).to have_content("#{pet_1.description}")
    expect(page).to have_content("#{pet_1.adoptable}")
    expect(page).to have_no_content("#{pet_2.name}")
    end
  end
end

describe 'As a visitor' do
  describe 'when I visit /pets/:id' do
    it 'has a link to delete shelter and the shelter is deleted when I click' do
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

    visit "/pets/#{pet_1.id}"
    expect(page).to have_link("Delete Pet")
    click_on("Delete Pet")
    expect(current_path).to eq("/pets")
    expect(page).to have_no_content("#{pet_1.name}")
    expect(page).to have_content("#{pet_2.name}")
    end
  end
end

describe "As a visitor" do
  describe "When I visit a pet's show page" do
    it "Has a link to view all apps for this pet" do
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

      expect(page).to have_link("All Applications")
      click_link("All Applications")
      expect(current_path).to eq("/pet-applications/#{pet_1.id}")
    end
  end
end
