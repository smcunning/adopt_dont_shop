require 'rails_helper'
describe 'Pet Show' do
  describe 'when I visit /pets/:id' do
      it 'shows the pet with that id' do
    pet_1 = Pet.create(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                       name: 'Skye',
                       approx_age: 3,
                       sex: 'Female',
                       description: 'Shy and loveable!',
                       adoptable: true)
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
