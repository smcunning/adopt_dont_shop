class Application < ApplicationRecord
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def all_pet_apps_approved?
    pet_applications.all.count == pet_applications.where(status: "Approved").count
  end

  def any_pet_apps_denied?
    pet_applications.where(status: "Denied").any?
  end

  def update_pet_adoptability
    pets.each do |pet|
     pet.adoptable = false
     pet.save
   end
  end
end
