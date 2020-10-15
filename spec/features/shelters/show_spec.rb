require 'rails_helper'
describe 'As a visitor' do
  describe 'when I visit /shelters/:id' do
    it 'then I see the shelter with that id and all its info' do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)

    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_content("#{shelter_1.name}")
    expect(page).to have_content("#{shelter_1.address}")
    expect(page).to have_content("#{shelter_1.city}")
    expect(page).to have_content("#{shelter_1.state}")
    expect(page).to have_content("#{shelter_1.zip}")
    end
  end
end

describe 'As a visitor' do
  describe 'when I visit /shelters/:id' do
    it 'has a link to delete shelter and the shelter is deleted when I click' do
    shelter_1 = Shelter.create(name: 'Nights Shelter',
                               address: '1234 Happy Lane',
                               city: 'Hopscotch Town',
                               state: 'Colorado',
                               zip: 12345)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_link("Delete Shelter")
    click_on("Delete Shelter")
    expect(current_path).to eq("/shelters")
    expect(page).to have_no_link("#{shelter_1.name}")
    end
  end
end

describe 'As a visitor' do
  describe 'when I visit /shelters/:id' do
    it 'has a link to take me to that shelters pets page' do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)

      pet_1 = Pet.create(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                         name: 'Skye',
                         approx_age: 3,
                         sex: 'Female',
                         shelter_id: shelter_1.id)
      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_link("See Our Pets")
      click_on("See Our Pets")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
    end
  end
end

describe "As a visitor" do
  describe "When I visit a shelter's show page" do
    it "Has a list of reviews for that shelter" do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      shelter_2 = Shelter.create(name: "The Cat's Meow",
                                 address: '654 Main',
                                 city: 'Denver',
                                 state: 'Colorado',
                                 zip: 80111)
      user = User.create!(name: "Betty",
                          address: "123 Main st",
                          city: "Denver",
                          state: "CO",
                          zip: 80111)
      review_1 = Review.create!(title: 'Best shelter ever.',
                                rating: 5,
                                content: 'My new pet is the best!',
                                image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                                shelter_id: "#{shelter_1.id}",
                                user_id: "#{user.id}")
      review_2 = Review.create!(title: 'Great place!',
                                rating: 4,
                                content: 'I love Mr. Mittens!',
                                shelter_id: "#{shelter_1.id}",
                                user_id: "#{user.id}")
      review_3 = Review.create!(title: 'Most amazing.',
                                rating: 4,
                                content: 'I love Mr. Barks!',
                                shelter_id: "#{shelter_2.id}",
                                user_id: "#{user.id}")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content('Best shelter ever.')
      expect(page).to have_content("#{user.name}")
      expect(page).to have_content(5)
      expect(page).to have_content('My new pet is the best!')
      expect(page).to have_xpath("//img[contains(@src,'#{review_1.image}')]")
      expect(page).to have_content('I love Mr. Mittens!')
      expect(page).to have_no_content("I love Mr. Barks!")
    end
  end
end

describe  "As a visitor" do
  describe "When I visit a shelter's show page" do
    it "It  has a link to add a new review for this shelter" do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_link("Add a Review")
      click_on("Add a Review")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
    end
    it "Has a form where I enter a new review" do
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
      click_on("Submit")

      expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
    end
  end
end

describe "As a visitor," do
  describe "When I visit a shelter's show page," do
    it "Then I see a link to edit the shelter review next to each review." do
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
      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_link("Edit Review")
    end
  end
end

describe "As a visitor," do
  describe "When I visit a shelter's show page," do
    it "Then I see a link next to each shelter review to delete the review." do
    shelter_1 = Shelter.create(name: 'Happy Home',
                               address: '1234 Happy Lane',
                               city: 'Hopscotch Town',
                               state: 'Colorado',
                               zip: 12345)
    user = User.create!(name: "Betty",
                        address: "123 Main st",
                        city: "Denver",
                        state: "CO",
                        zip: 80111)
    review_1 = Review.create!(title: 'Tubular!',
                              rating: 5,
                              content: 'My new pet is the best!',
                              image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                              user_id: "#{user.id}",
                              shelter_id: "#{shelter_1.id}")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_link("Delete Review")

    click_link("Delete Review")

    expect(page).not_to have_content("#{review_1.title}")
    end
  end
end
