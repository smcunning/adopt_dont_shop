require 'rails_helper'

describe Application, type: :model do
  describe "relationships" do
    it {should belong_to(:user)}
    it {should have_many(:pet_applications)}
    it {should have_many(:pets).through(:pet_applications)}
  end

  describe "instance methods" do
    it "all_pet_apps_approved? true" do
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
      application_1 = Application.create!(description: "I will take great care of Skye",
                                        status: "In Progress",
                                        user_id: user.id)
      pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                               user_id: user.id,
                                               application_id: application_1.id,
                                               status: "Approved")
      pet_application_2 = PetApplication.create!(pet_id: pet_1.id,
                                               user_id: user.id,
                                               application_id: application_1.id,
                                               status: "Approved")

      expect(application_1.all_pet_apps_approved?).to eq(true)
    end
  end

  it "all_pet_apps_approved? false" do
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
    application_1 = Application.create!(description: "I will take great care of Skye",
                                      status: "In Progress",
                                      user_id: user.id)
    pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                             user_id: user.id,
                                             application_id: application_1.id,
                                             status: "Approved")
    pet_application_2 = PetApplication.create!(pet_id: pet_1.id,
                                             user_id: user.id,
                                             application_id: application_1.id,
                                             status: "Denied")


    expect(application_1.all_pet_apps_approved?).to eq(false)
  end

  it "any_pet_apps_denied? true" do
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
    application_1 = Application.create!(description: "I will take great care of Skye",
                                      status: "In Progress",
                                      user_id: user.id)
    pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                             user_id: user.id,
                                             application_id: application_1.id,
                                             status: "Approved")
    pet_application_2 = PetApplication.create!(pet_id: pet_1.id,
                                             user_id: user.id,
                                             application_id: application_1.id,
                                             status: "Denied")

    expect(application_1.any_pet_apps_denied?).to eq(true)
  end

  it "any_pet_apps_denied? false" do
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
    application_1 = Application.create!(description: "I will take great care of Skye",
                                      status: "In Progress",
                                      user_id: user.id)
    pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                             user_id: user.id,
                                             application_id: application_1.id,
                                             status: "Approved")
    pet_application_2 = PetApplication.create!(pet_id: pet_1.id,
                                             user_id: user.id,
                                             application_id: application_1.id,
                                             status: "Approved")

    expect(application_1.any_pet_apps_denied?).to eq(false)
  end

  it "update_pet_adoptability" do
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
    pet_2 = Pet.create(image: 'https://i.ibb.co/JzcLkB6/pet-1.jpg',
                       name: 'Samson',
                       approx_age: 3,
                       sex: 'Male',
                       shelter_id: shelter_1.id)
    application_1 = Application.create!(description: "I will take great care of Skye",
                                      status: "In Progress",
                                      user_id: user.id)
    pet_application_1 = PetApplication.create!(pet_id: pet_1.id,
                                               user_id: user.id,
                                               application_id: application_1.id,
                                               status: "Approved")

    application_1.update_pet_adoptability
    expect(pet_1.adoptable).to eq(false)
    expect(pet_2.adoptable).to eq(false)
  end
end
