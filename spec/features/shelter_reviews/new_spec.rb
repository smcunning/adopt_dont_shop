require 'rails_helper'

describe "As a visitor" do
  describe "When I click on the link to create a new review" do
    it "Takes me to a page that has a form where I enter a new review" do
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
      review_1 = Review.create!(title: 'Best shelter ever.',
                                rating: 5,
                                content: 'My new pet is the best!',
                                image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                                user_id: "#{user.id}",
                                shelter_id: "#{shelter_1.id}")

      visit "/shelters/#{shelter_1.id}/reviews/new"

      expect(page).to have_field("title")
      expect(page).to have_field("rating")
      expect(page).to have_field("content")
      expect(page).to have_field("user_name")
      expect(page).to have_field("image")

      fill_in :title, with: "Stellar place!"
      fill_in :rating, with: 5
      fill_in :content, with: "I love Mr. Mittens"
      fill_in :user_name, with: "#{user.name}"
      fill_in :image, with: "https://i.ibb.co/fvxM0QB/Mr-Mittens.jpg"
      click_on("Submit")

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("Stellar place!")
      expect(page).to have_xpath("//img[contains(@src,'https://i.ibb.co/fvxM0QB/Mr-Mittens.jpg')]")
    end

  it "Can't submit a review from a user not in the database" do
    shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                               address: '1234 Happy Lane',
                               city: 'Hopscotch Town',
                               state: 'Colorado',
                               zip: 12345)

    visit "/shelters/#{shelter_1.id}/reviews/new"

    fill_in :title, with: "Stellar place!"
    fill_in :rating, with: 5
    fill_in :content, with: "I love Mr. Mittens"
    fill_in :user_name, with: "Joe"
    fill_in :image, with: "https://i.ibb.co/fvxM0QB/Mr-Mittens.jpg"
    click_button("Submit")

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
    end
  end
end

describe "As a visitor" do
  describe "When I visit the new review page, and enter the name
  of a user that doesn't exist" do
    it "Shows a flash message that user can't be found." do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)

      visit "/shelters/#{shelter_1.id}/reviews/new"

      fill_in :title, with: "Stellar place!"
      fill_in :rating, with: 5
      fill_in :content, with: "I love Mr. Mittens"
      fill_in :user_name, with: "Joe"
      fill_in :image, with: "https://i.ibb.co/fvxM0QB/Mr-Mittens.jpg"
      click_button("Submit")

      expect(page).to have_content("💥 Not a valid User: Please enter the name of a registered user. 💥")

      expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

    end
  end
end

describe "As a visitor" do
  describe "When I visit the new review page, and fail to enter title, rating, and/or content" do
    it "shows a flash message indicating a title, rating, and content needs to be filled out." do
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

      visit "/shelters/#{shelter_1.id}/reviews/new"

      fill_in :title, with: "Stellar place!"
      fill_in :rating, with: 3
      fill_in :content, with: ""
      fill_in :user_name, with: "#{user.name}"
      fill_in :image, with: "https://i.ibb.co/fvxM0QB/Mr-Mittens.jpg"
      click_button("Submit")

      expect(page).to have_content("Please fill out title, rating, and content to submit review")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

    end
  end
end
