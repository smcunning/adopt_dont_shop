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
    shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                               address: '1234 Happy Lane',
                               city: 'Hopscotch Town',
                               state: 'Colorado',
                               zip: 12345)

    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_link("Delete Shelter")
    click_on("Delete Shelter")
    expect(current_path).to eq("/shelters")
    expect(page).to have_no_content("#{shelter_1.name}")
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
      user = User.create!(name: "Betty",
                          address: "123 Main st",
                          city: "Denver",
                          state: "CO",
                          zip: 80111)
      review_1 = Review.create!(title: 'Best shelter ever.',
                                rating: 5,
                                content: 'My new pet is the best!',
                                image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                                user: "#{user.name}",
                                shelter_id: "#{shelter_1.id}")
      review_2 = Review.create!(title: 'Great place!',
                                rating: 4,
                                content: 'I love Mr. Mittens!',
                                user: "#{user.name}",
                                shelter_id: "#{shelter_1.id}")

      visit "/shelters/#{shelter_1.id}"
      save_and_open_page
      expect(page).to have_content('Best shelter ever.')
      expect(page).to have_content("#{user.name}")
      expect(page).to have_content(5)
      expect(page).to have_content('My new pet is the best!')
      expect(page).to have_xpath("//img[contains(@src,'#{review_1.image}')]")
      expect(page).to have_content('I love Mr. Mittens!')
    end
  end
end
