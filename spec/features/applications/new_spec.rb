require 'rails_helper'

describe 'when i visit applications/new' do
  describe 'I see a form where I can fill in information' do
    it 'takes me to new applications show page when I submit' do
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

      visit '/applications/new'

      within('.app-form') do
        expect(page).to have_field("user_name")
        expect(page).to have_button("Submit")
      end
      fill_in :user_name, with: user.name
      click_button("Submit")

      within('.user-info') do
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.full_address)
      end

      within('.application') do
        expect(page).to have_content("In Progress")
      end
    end

    it 'needs a valid user' do
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

      visit '/applications/new'
      fill_in :user_name, with: "Kim Kardashian"
      click_button("Submit")
      expect(current_path).to eq '/applications/new'
      expect(page).to have_content("Please enter an existing user name.")
    end
  end
end
