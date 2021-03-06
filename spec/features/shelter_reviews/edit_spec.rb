require 'rails_helper'

describe "As a vistor" do
  it "When I click on the edit link, I am taken to an edit shelter review path.
  On this new page, I see a form that includes that review's pre populated data:" do
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

  click_on("Edit Review")

  expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")
  expect(page).to have_field("title")
  expect(find_field("title").value).to eq "#{review_1.title}"
  expect(page).to have_field("rating")
  expect(find_field("rating").value).to eq "#{review_1.rating}"
  expect(page).to have_field("content")
  expect(find_field("content").value).to eq "#{review_1.content}"
  expect(page).to have_field("image")
  expect(find_field("image").value).to eq "#{review_1.image}"
  expect(page).to have_field("user_name")
  expect(find_field("user_name").value).to eq "#{user.name}"
  end

  it "On this edit page I am able to update the fields" do
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

    visit "/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit"

    fill_in :title, with: "Worst place ever"
    fill_in :rating, with: 1
    fill_in :image, with: ""
    fill_in :content, with: "They called me names."

    click_button("Update Review")

    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    expect(page).to have_content("Worst place ever")
    expect(page).to have_content(1)
    expect(page).to have_content("They called me names.")
    expect(page).not_to have_xpath("//img[contains(@src,'https://i.ibb.co/JzcLkB6/pet-1.jpg')]")
    expect(page).to have_content("#{review_1.user.name}")
  end
end

describe "As a visitor" do
  describe "When I visit the page to edit a review, and I fail to enter
  a title, rating, and/or content in the edit shelter review form" do
    it "I see a flash message indicating that I need to fill in a title,
    rating, and content in order to edit the review and returned to the edit form" do
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

    visit "/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit"

    fill_in :title, with: ""
    fill_in :rating, with: 5
    fill_in :image, with: ""
    fill_in :content, with: "They called me names."

    click_button("Update Review")

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")
    expect(page).to have_content("Title, Rating, and Content cannot be blank.")
    end
  end
end

describe "As a visitor" do
  describe "When I visit the page to edit a review,
  and enter the name of a user that doesn't exist" do
    it "Has a flash message indicating the user cannot be found." do
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

      visit "/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit"

      fill_in :user_name, with: "Dale"

      click_button("Update Review")

      expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")

      expect(page).to have_content("User does not exist, please enter valid user")
    end
  end
end
