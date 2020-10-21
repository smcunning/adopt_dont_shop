require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  it "knows if apps are approved" do
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
    pet_1 = Pet.create(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                       name: 'Skye',
                       approx_age: 3,
                       sex: 'Female',
                       shelter_id: shelter_1.id)
    application = Application.create!(description: "I will take great care of Skye",
                                      status: "Approved",
                                      user_id: user.id)
    pet_application = PetApplication.create!(pet_id: pet_1.id,
                                             user_id: user.id,
                                             application_id: application.id)

    expect(pet_1.apps_approved?).to eq(true)
  end

  it "knows if apps are NOT approved" do
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
    pet_1 = Pet.create(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                       name: 'Skye',
                       approx_age: 3,
                       sex: 'Female',
                       shelter_id: shelter_1.id)
    application = Application.create!(description: "I will take great care of Skye",
                                      status: "In Progress",
                                      user_id: user.id)
    pet_application = PetApplication.create!(pet_id: pet_1.id,
                                             user_id: user.id,
                                             application_id: application.id)

    expect(pet_1.apps_approved?).to eq(false)
  end

  it 'can find pet application by application id' do
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
    pet_1 = Pet.create(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                       name: 'Skye',
                       approx_age: 3,
                       sex: 'Female',
                       shelter_id: shelter_1.id)
    application = Application.create!(description: "I will take great care of Skye",
                                      status: "In Progress",
                                      user_id: user.id)
    pet_application = PetApplication.create!(pet_id: pet_1.id,
                                             user_id: user.id,
                                             application_id: application.id)

    expect(pet_1.find_pet_application(application.id)).to eq(pet_application)
  end
end
