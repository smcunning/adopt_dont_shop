require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/admin/applications/:id'
   I see every pet the application is for and" do
    it "Has a button to approve the application for that specific pet" do
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

      visit "/admin/applications/#{application.id}"
      within "#pet-#{pet_1.id}" do
        expect(page).to have_button("Approve")
      end

    end
    it "Takes me to admin application show page where pet's status is approved." do
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

      visit "/admin/applications/#{application.id}"

      within "#pet-#{pet_1.id}" do
        click_button("Approve")
        expect(page).to_not have_button("Approve")
      end

      within ".app-info" do
        expect(page).to have_content("Approved")
      end
    end
  end
end

describe "As a visitor" do
  describe  "When I visit admin app show page" do
    it "Has a button to reject the application for that specific pet" do
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

      visit "/admin/applications/#{application.id}"

      within "#pet-#{pet_1.id}" do
        expect(page).to have_button("Deny")
      end
    end

    it "Has a button to deny application" do
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

      visit "/admin/applications/#{application.id}"

      within "#pet-#{pet_1.id}" do
        click_button("Deny")
        expect(page).to_not have_button("Deny")
      end
      within ".app-info" do
        expect(page).to have_content("Denied")
      end
    end
  end
end

describe "As a visitor" do
  describe "When I visit an admin application show page" do
    it "I can approve all pets for an application" do
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
      pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                               user_id: user.id,
                                               application_id: application.id)
      pet_2 = Pet.create(image: 'https://i.ibb.co/VjrXKY5/awww.jpg',
                         name: 'Henry',
                         approx_age: 1,
                         sex: 'Male',
                         shelter_id: shelter_1.id)
      pet_application_2 = PetApplication.create!(pet_id: pet_2.id,
                                               user_id: user.id,
                                               application_id: application.id)

      visit "/admin/applications/#{application.id}"

      within "#pet-#{pet_1.id}" do
        click_button("Approve")
        expect(page).to_not have_button("Approved")
      end

      expect(page).to have_content("In Progress")

      within "#pet-#{pet_2.id}" do
        click_button("Approve")
        expect(page).to_not have_button("Approved")
      end

      expect(page).to have_content("Approved")
    end
  end
end

describe "As a visitor" do
  describe "When pet is approved with pending application" do
    it "The page omits the reject or approve button" do
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
      application_1 = Application.create!(description: "I will take great care of Skye",
                                        status: "In Progress",
                                        user_id: user.id)
      application_2 = Application.create!(description: "I love kittens!",
                                        status: "In Progress",
                                        user_id: user.id)
      pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                               user_id: user.id,
                                               application_id: application_1.id)
      pet_application_2 = PetApplication.create!(pet_id: pet_1.id,
                                               user_id: user.id,
                                               application_id: application_2.id)

      visit "/admin/applications/#{application_1.id}"

      within "#pet-#{pet_1.id}" do
        click_button("Approve")
      end

      visit "/admin/applications/#{application_2.id}"

      expect(page).to have_content("This pet has already been adopted.")
      expect(page).to_not have_button("Approve")
      expect(page).to_not have_button("Deny")
    end
  end
end
