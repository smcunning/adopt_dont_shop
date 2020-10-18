class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  validates_presence_of :image, :name, :approx_age, :sex

  def pet_application(application_id)
    PetApplication.find_by(pet_id: id, application_id: application_id)
  end
end
