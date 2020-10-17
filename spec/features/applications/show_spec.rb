require 'rails_helper'

describe 'as a visitor' do
  describe 'on the applications show page' do
    it 'has all that applications information' do
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

      visit "applications/#{application.id}"

      within(".user-info") do
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.full_address)
      end

      within(".application") do
        expect(page).to have_content(application.description)
        expect(page).to have_link(pet_1.name)
        expect(page).to have_content(application.status)
      end
    end
  end
end


describe 'Add pet to application section' do
  it 'has input field where I can search for Pets by name' do
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
   pet_2 = Pet.create(image: 'https://i.ibb.co/jJK9jWN/pet-2.jpg',
                      name: 'Skye',
                      approx_age: 1,
                      sex: 'Male',
                      shelter_id: shelter_1.id)
    application = Application.create!(description: "I will take great care of Skye",
                                      status: "In Progress",
                                      user_id: user.id)
    # pet_application = PetApplication.create!(pet_id: pet_1.id,
    #                                          user_id: user.id,
    #                                          application_id: application.id)

    visit "/applications/#{application.id}"

    within '.add-pet' do
      expect(page).to have_field("Search For Pet")
    end

    fill_in "Seach for Pet", with: "Skye"
    click_button("Submit")
    expect(current_path).to eq("/applications/#{application.id}")

    #need testing for order - that the search bar is on top of the pet results

    within '.pet-results'do
      expect(page).to have_content(pet_1.image)
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.approx_age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(pet_2.image)
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.approx_age)
      expect(page).to have_content(pet_2.sex)
    end
  end
end
