require 'rails_helper'

describe User, type: :model do
  describe "relationships" do
    it { should have_many :reviews}
    it { should have_many :applications}

  end

  describe "instance methods" do
    it "average_rating_rating" do
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

      average = ((review_1.rating + review_2.rating + review_3.rating) / 3.to_f).round(2)

      expect(user_1.average_rating.round(2)).to eq(average)
    end

     it "best_review" do
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

       best = {
         title: review_1.title,
         rating: review_1.rating,
         content: review_1.content,
         image: review_1.image
       }


       expect(user_1.best_review).to eq(best)
     end

     it "worst_review" do
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

       worst = {
         title: review_3.title,
         rating: review_3.rating,
         content: review_3.content,
         image: review_3.image
       }


       expect(user_1.worst_review).to eq(worst)
     end

    it "no review content" do
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

      expect(user_1.best_review[:title]).to eq("Nothing found.")
      expect(user_1.best_review[:rating]).to eq("Nothing found.")
      expect(user_1.best_review[:content]).to eq("Nothing found.")
      expect(user_1.worst_review[:title]).to eq("Nothing found.")
      expect(user_1.worst_review[:rating]).to eq("Nothing found.")
      expect(user_1.worst_review[:content]).to eq("Nothing found.")
    end
  end
end
