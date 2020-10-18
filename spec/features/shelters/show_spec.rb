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

describe "As a visitor" do
  describe "When I visit a shelter's show page" do
    it "I see count of pets at that shelter, average shelter review rating,
    and number of applications on file for that shelter" do
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
      review_2 = Review.create!(title: 'Pleasant place',
                                rating: 5,
                                content: 'The staff was very friendly.',
                                image: '',
                                user_id: "#{user.id}",
                                shelter_id: "#{shelter_1.id}")
      pet_1 = Pet.create!(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                         name: 'Skye',
                         approx_age: 3,
                         sex: 'Female',
                         description: 'Shy and loveable!',
                         adoptable: true,
                         shelter_id: shelter_1.id)
      pet_2 = Pet.create!(image: 'https://i.ibb.co/jJK9jWN/pet-2.jpg',
                        name: 'Gigi',
                        approx_age: 4,
                        sex: 'Female',
                        description: 'Talkative and playful!',
                        adoptable: true,
                        shelter_id: shelter_1.id)
      application_1 = Application.create!(description: "I will take great care of Skye",
                                        status: "In Progress",
                                        user_id: user.id)
      application_2 = Application.create!(description: "I've taken care of dogs my whole life.",
                                        status: "In Progress",
                                        user_id: user.id)
      pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                               user_id: user.id,
                                               application_id: application_1.id)

      pet_application_2 = PetApplication.create!(pet_id: pet_2.id,
                                               user_id: user.id,
                                               application_id: application_2.id)

      visit "/shelters/#{shelter_1.id}"

      within(".shelter-stats") do
        expect(page).to have_content(shelter_1.pets_count)
        expect(page).to have_content(shelter_1.average_rating)
        expect(page).to have_content(shelter_1.application_count)
      end
    end
  end
end

describe "As a visitor" do
  describe "If a shelter has approved applications for any of their pets" do
    it "The shelter cannot be deleted" do
      shelter_1 = Shelter.create(name: 'Happy Home',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      pet_1 = Pet.create!(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                         name: 'Skye',
                         approx_age: 3,
                         sex: 'Female',
                         description: 'Shy and loveable!',
                         adoptable: true,
                         shelter_id: shelter_1.id)
      user = User.create!(name: "Betty",
                          address: "123 Main st",
                          city: "Denver",
                          state: "CO",
                          zip: 80111)
      application_1 = Application.create!(description: "I will take great care of Skye",
                                        status: "Pending",
                                        user_id: user.id)
      pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                               user_id: user.id,
                                               application_id: application_1.id)

      visit "/shelters/#{shelter_1.id}"

      click_link("Delete Shelter")

      expect(page).to have_content("Shelters with pending applications CANNOT be deleted!")
      expect(page).to have_content("#{shelter_1.name}")
    end
  end
end
