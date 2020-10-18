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

      visit "/admin/applications/#{application.id}"

      within "#pet-#{pet_1.id}" do
        click_button("Approve")
        expect(page).to have_content("Approved")
        expect(page).to_not have_button("Approve")
      end
    end
  end
end
