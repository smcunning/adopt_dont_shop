require 'rails_helper'

describe "As a visitor" do
  describe "On the index page for a specific pet" do
    it "has a list of applicants with links to their application show pages" do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      user_1 = User.create!(name: "Betty",
                          address: "123 leet st",
                          city: "Denver",
                          state: "CO",
                          zip: 80111)
      user_2 = User.create!(name: "Bob",
                          address: "123 Main st",
                          city: "Denver",
                          state: "CO",
                          zip: 80111)
      user_3 = User.create!(name: "Billy",
                          address: "123 lame st",
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
                                        user_id: user_1.id)
      application_2 = Application.create!(description: "I will take great care of Skye",
                                        status: "In Progress",
                                        user_id: user_2.id)
      application_3 = Application.create!(description: "I will take great care of Skye",
                                        status: "In Progress",
                                        user_id: user_3.id)

      visit "/pets/#{pet_1.id}"

      click_link("All Applications")
      expect(current_path).to eq("/pet-applications")
save_and_open_page
      within(".applicant-#{user_1.id}") do
        expect(page).to have_link("#{user_1.name}")
      end
      within(".applicant-#{user_2.id}") do
        expect(page).to have_link("#{user_2.name}")
      end
      within(".applicant-#{user_3.id}") do
        expect(page).to have_link("#{user_3.name}")
        click_link("#{user_3.name}")
      end

      expect(current_path).to eq("/admin/applications/#{application_3.id}")
    end
  end
end
