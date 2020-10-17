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

describe "As a visitor" do
  describe "When I visit a User's show page" do
    it "Then I see every review this User has written" do
      shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                                 address: '1234 Happy Lane',
                                 city: 'Hopscotch Town',
                                 state: 'Colorado',
                                 zip: 12345)
      user_1 = User.create!(name: "Betty",
                          address: "123 Main st",
                          city: "Denver",
                          state: "CO",
                          zip: 80111)
      user_2 = User.create!(name: "Jim",
                          address: "9846 Lane",
                          city: "Denver",
                          state: "CO",
                          zip: 80111)
      review_1 = Review.create!(title: 'Best shelter ever.',
                                rating: 5,
                                content: 'My new pet is the best!',
                                image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                                shelter_id: "#{shelter_1.id}",
                                user_id: "#{user_1.id}")
      review_2 = Review.create!(title: 'Great place!',
                                rating: 4,
                                content: 'I love Mr. Mittens!',
                                shelter_id: "#{shelter_1.id}",
                                user_id: "#{user_1.id}")
      review_3 = Review.create!(title: 'Stellar!',
                                rating: 4,
                                content: 'Super duper clean',
                                shelter_id: "#{shelter_1.id}",
                                user_id: "#{user_2.id}")

      visit "/users/#{user_1.id}"

      expect(page).to have_content('Best shelter ever.')
      expect(page).to have_content(5)
      expect(page).to have_content('My new pet is the best!')
      expect(page).to have_content('Great place!')
      expect(page).to have_content(4)
      expect(page).to have_content('I love Mr. Mittens!')
      expect(page).to have_no_content('Super duper clean')
    end
  end
end

describe 'Within the highlighted reviews on user show page'do
  it 'has a the best rating and worst rating this user has written' do
    shelter_1 = Shelter.create(name: 'Sunny Days Shelter',
                               address: '1234 Happy Lane',
                               city: 'Hopscotch Town',
                               state: 'Colorado',
                               zip: 12345)
    user_1 = User.create!(name: "Betty",
                        address: "123 Main st",
                        city: "Denver",
                        state: "CO",
                        zip: 80111)
    review_1 = Review.create!(title: 'Best shelter ever.',
                              rating: 5,
                              content: 'My new pet is the best!',
                              image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                              shelter_id: "#{shelter_1.id}",
                              user_id: "#{user_1.id}")
    review_2 = Review.create!(title: 'Great place!',
                              rating: 4,
                              content: 'I love Mr. Mittens!',
                              shelter_id: "#{shelter_1.id}",
                              user_id: "#{user_1.id}")
    review_3 = Review.create!(title: 'Will not be returning',
                              rating: 1,
                              content: 'No one was working',
                              shelter_id: "#{shelter_1.id}",
                              user_id: "#{user_1.id}")

    visit "/users/#{user_1.id}"

    within ".best" do
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.rating)
      expect(page).to have_content(review_1.content)
    end

    within ".worst" do
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.rating)
      expect(page).to have_content(review_2.content)
    end
  end
end
