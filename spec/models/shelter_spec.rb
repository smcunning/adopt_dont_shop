require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :pets}
  end

  it "Knows count of pets" do
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
    pet_2 = Pet.create!(image: 'https://i.ibb.co/jJK9jWN/pet-2.jpg',
                      name: 'Gigi',
                      approx_age: 4,
                      sex: 'Female',
                      description: 'Talkative and playful!',
                      adoptable: true,
                      shelter_id: shelter_1.id)

  expect(shelter_1.pets_count).to eq(2)
  end

  it "Knows average rating" do
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
                              rating: 3,
                              content: 'The staff was very friendly.',
                              image: '',
                              user_id: "#{user.id}",
                              shelter_id: "#{shelter_1.id}")

    expect(shelter_1.average_rating).to eq(4)
  end

  it "Knows how many apps it has" do
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

    expect(shelter_1.application_count).to eq(2)
  end
end
