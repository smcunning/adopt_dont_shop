require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a user's show page" do
    it "Has all the user's information" do
      user = User.create!(name: "Betty",
                          address: "123 Main st",
                          city: "Denver",
                          state: "CO",
                          zip: 80111)

      visit "/users/#{user.id}"

      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{user.address}")
      expect(page).to have_content("#{user.city}")
      expect(page).to have_content("#{user.state}")
      expect(page).to have_content("#{user.zip}")

    end
  end
end
