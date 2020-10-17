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

    visit "/applications/#{application.id}"

    within '.find-pet' do
      expect(page).to have_field(:pet_name)
    end

    fill_in :pet_name, with: "Skye"
    click_button("Submit")
    expect(current_path).to eq("/applications/#{application.id}")

    #need testing for order - that the search bar is on top of the pet results

    within '.pet-results'do
      expect(page).to have_xpath("//img[contains(@src,'#{pet_1.image}')]")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.approx_age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_xpath("//img[contains(@src,'#{pet_2.image}')]")
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.approx_age)
      expect(page).to have_content(pet_2.sex)
    end
  end

  it 'has a link next to each pet to adopt this pet' do
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
    visit "/applications/#{application.id}"
    fill_in :pet_name, with: "Skye"
    click_button("Submit")

    within "#pet-#{pet_1.id}" do
      expect(page).to have_button("Adopt This Pet")
    end

    within "#pet-#{pet_2.id}" do
      expect(page).to have_button("Adopt This Pet")
    end

    within "#pet-#{pet_1.id}" do
      click_button("Adopt This Pet")
    end

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content(pet_1.name)
    expect(page).to_not have_content(pet_2.sex)
  end
end

describe 'submit an application' do
  describe 'with one+ pets I see submit section to submit application' do
    it 'has input field for description and button to sumbit application' do
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
      application = Application.create!(status: "In Progress",
                                        user_id: user.id)

      visit "/applications/#{application.id}"
      fill_in :pet_name, with: "Skye"
      click_button("Submit")
      within "#pet-#{pet_1.id}" do
        click_button("Adopt This Pet")
      end

      within ".submit-app" do
        expect(page).to have_field(:description)
        expect(page).to have_button("Submit Application")
        fill_in :description, with: "I am the best fetch partner."
        click_button("Submit Application")
      end

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Pending")
      expect(page).to have_content(pet_1.name)
      expect(page).to_not have_button("Adopt This Pet")
      expect(page).to_not have_field(:pet_name)
    end
  end
end

describe 'incomplete applications for submitting' do
  it 'will redirect back to the show page with a flash message' do
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
    application = Application.create!(status: "In Progress",
                                      user_id: user.id)

    visit "/applications/#{application.id}"
    fill_in :pet_name, with: "Skye"
    click_button("Submit")

    within "#pet-#{pet_1.id}" do
      click_button("Adopt This Pet")
    end

    within ".submit-app" do
      click_button("Submit Application")
    end
    save_and_open_page
    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("In Progress")
    expect(page).to have_content("You must enter a description.")
  end
end
