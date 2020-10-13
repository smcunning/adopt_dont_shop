require 'rails_helper'

describe "As a visitor" do
  describe "When I visit '/users/new'" do
    it "Has a form to create a new user" do

      visit "/users/new"

      expect(page).to have_field(:name)
      expect(page).to have_field(:address)
      expect(page).to have_field(:city)
      expect(page).to have_field(:state)
      expect(page).to have_field(:zip)
    end

    it "Allows me to fill in the data,
     then directs me to the user show page" do

      visit "/users/new"

      fill_in :name, with: "Susan"
      fill_in :address, with: "123 Main St"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: 80111
      click_on("Create User")
      expect(page).to have_content("Susan")
    end
  end
end
